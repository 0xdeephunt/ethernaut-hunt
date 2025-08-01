# Level 17: Recovery

### Wargame
A contract creator has built a very simple token factory contract. Anyone can create new tokens with ease. After deploying the first token contract, the creator sent 0.001 ether to obtain more tokens. They have since lost the contract address.
This level will be completed if you can recover (or remove) the 0.001 ether from the lost contract address.

### Key Insights
* factory contract

### Attack Steps
1. Before executing the attack, display the address of the target contract. 
Please note that the address is the contract Recovery address, not the contract SimpleToken address.
    ```bash
    > instance
    '0xb79ED325e6c6302B940198c9aF33c290914241eD'
    ```

2. Enter this URL to view contract Recovery information, including the contracts created by contract Recovery.
https://sepolia.etherscan.io/address/0xb79ED325e6c6302B940198c9aF33c290914241eD#internaltx

3. The contract SimpleToken address is found, which is '0x87361103052c8CfA478a893766Cd6B01B2aEb50e'.

4. Deploy contract RecoveryAttack contract with contract SimpleToken address.

5. Call attack() of the RecoveryAttack contract, which will call destroy function of the Recovery contract.
