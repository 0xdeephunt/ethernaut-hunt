# Level 16: Preservation

### Wargame
The goal of this level is for you to claim ownership of the instance you are given.

### Key Insights
* delegatecall
* storage slot
* Use delegatecall to overwrite the owner storage slot via a malicious library contract.

### Attack Steps
1. Before executing the attack, display the owner of the target contract. 
    ```bash
    > instance
    '0xCAf1B588c2E2287B0F4836DE2186CF4aDdca1548'

    > player
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'

    > await contract.owner()
    '0x7ae0655F0Ee1e7752D7C62493CEa1E69A810e2ed'

    > await contract.timeZone1Library()
    '0xf88ed7D1Dfcd1Bb89a975662fd7cB536058F3a30'
    ```

2. Deploy Contract PreservationAttack contract with target address.

3. Call attackPrepare() of the PreservationAttack contract. The timeZone1Library of the target contract is changed to the address of the NaughtCoinAttack contract.
    ```bash
    > await contract.timeZone1Library()
    '0x9891c613d9c758DC90d4CE3353DDD78b5c416961'
    ```

4. Call attack() of the PreservationAttack contract. The owner of the target contract is changed to the player address.
    ```bash
    > await contract.owner()
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```



