# Level 14: GatekeeperTwo

### Wargame
Register as an entrant to pass this level.

### Key Insights
* How to satisfy the condition extcodesize(caller()) == 0 through a contract call
* You can satisfy this requirement by making the call from within the constructor of another contract.

### Attack Steps
1. Before executing the attack, display the entrant value of the target contract - it would be zero.
    ```bash
    > instance
    '0x98dABc5a3e7FF99bbEEF11417cA38810132550A2'

    > await contract.entrant()
    '0x0000000000000000000000000000000000000000'
    ```

2. Deploy Contract GatekeeperTwoHunt with Target Address, whose constructor will attack the target contract!

3. After the attack transaction is confirmed, check the target contract's entrant value again - it should be my Address.
    ```bash
    await contract.entrant()
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```
