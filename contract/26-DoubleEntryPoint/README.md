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
