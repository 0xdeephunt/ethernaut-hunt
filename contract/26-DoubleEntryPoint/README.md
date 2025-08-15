# Level 26: DoubleEntryPoint

## Wargame
In this level you should figure out where the bug is in CryptoVault and protect it from being drained out of tokens.

## Attack Steps

### 1. Instance Address
  ```
  0x63fc2F7E669D3c75A2e1A3592E5CA0b718C98f9a
  ```

---

### 2. Deploy Attack Contract
Deploy the `DoubleEntryPointAttack` contract, passing the **target contract address** as the constructor parameter.

---

### 3. Register the DetectionBot

- ABI Definition
```javascript
const fortaABI = [
    {
        inputs: [
            {
                internalType: "address",
                name: "detectionBotAddress",
                type: "address",
            },
        ],
        name: "setDetectionBot",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
    },
];
```

- Get Forta Contract Instance
  ```javascript
  const fortaAddress = await contract.forta();
  const fortaContract = new web3.eth.Contract(fortaABI, fortaAddress);
  ```

- Register the DetectionBot
  ```javascript
  const myContract = "0x55135b65BCd4D59e861a0F425E5DD5E61e5342C3"; // Deployed DoubleEntryPointAttack address

  await fortaContract.methods
      .setDetectionBot(myContract)
      .send({ from: player });
  ```

---

## 4. Execute the Attack
- Call `attack()` from `DoubleEntryPointAttack`:

- **If the DetectionBot is registered**:  
  Forta will trigger an alert, and the transaction will fail (the `transfer` will revert).
  
- **If the DetectionBot is NOT registered**:  
  The attack will succeed, transferring the "DET" token from the `CryptoVault` contract to the `player` address.


## Appendix: DoubleEntryPoint Exploit Call Flow Diagram

  ```
+----------------+       +-------------------+       +-----------------+       +-----------------+
|      EOA       |       |   CryptoVault     |       |   LegacyToken   |       | DoubleEntryPoint|
| (External User)|       |     Contract      |       |     Contract    |       |     Contract    |
+----------------+       +-------------------+       +-----------------+       +-----------------+
        |                        |                           |                           |
        |  1. calls              |                           |                           |
        +----------------------->|                           |                           |
        |   sweepToken(legacyTokenAddr)                      |                           |
        |                        |                           |                           |
        |                        |  2. calls                 |                           |
        |                        +-------------------------->|                           |
        |                        |transfer(recipient, amount)|                           |
        |                        |(msg.sender = CryptoVault) |                           |
        |                        |                           |                           |
        |                        |                           |  3. calls                 |
        |                        |                           +-------------------------->|
        |                        |                           | delegateTransfer(recipient, amount, origSender=CryptoVault)|
        |                        |                           | (msg.sender = LegacyToken)|                           |
        |                        |                           |                           |                           |
        |                        |                           |                           | 4. calls (internal)       |
        |                        |                           |                           +-------------------------->|
        |                        |                           |                           |_transfer(from, to, value) |
        |                        |                           |                           |                           |
+----------------+       +-------------------+       +-----------------+       +-----------------+
|      EOA       |       |   CryptoVault     |       |   LegacyToken   |       | DoubleEntryPoint|
+----------------+       +-------------------+       +-----------------+       +-----------------+
  ```

**Diagram Explanation**:
1. EOA -> CryptoVault.sweepToken: An external user initiates a transaction, calling the sweepToken function on the CryptoVault contract with the LegacyToken address as an argument.
2. CryptoVault -> LegacyToken.transfer: Inside its sweepToken function, the CryptoVault contract calls transfer on the LegacyToken. At this point, the msg.sender is the CryptoVault contract.
3. LegacyToken -> DoubleEntryPoint.delegateTransfer: The LegacyToken's transfer function has a unique implementation. Instead of performing a standard transfer, it calls delegateTransfer on the DoubleEntryPoint contract, passing the CryptoVault address as the origSender parameter.
4. DoubleEntryPoint -> _transfer: The delegateTransfer function first verifies that its caller (msg.sender) is the legitimate LegacyToken contract. Upon successful verification, it proceeds to call the internal _transfer function to execute the token transfer using the origSender address provided.