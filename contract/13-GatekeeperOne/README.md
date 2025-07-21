# Level 13: GatekeeperOne

### Wargame
Make it past the gatekeeper and register as an entrant to pass this level.

### Key Insights
* gasleft()
* Although you can use call{gas: xxx} to specify the amount of gas sent with a function call, you cannot directly control the exact value of gasleft() inside the called contract. The actual gasleft() value depends on how much gas has been consumed before the gasleft() check. Therefore, you must try different gas values iteratively to find one that satisfies gasleft() % 8191 == 0.

### Attack Steps
1. Deploy Building Contract GatekeeperOneAttack. Dis

2. Before executing the attack, display the entrant value of the target contract - it would be zero.
    ```bash
    > instance
    '0x336555B770f7c7aec400E41E51a274881CEfE4F2'

    > await contract.entrant()
    '0x0000000000000000000000000000000000000000'
    ```

3. Call attack() with Target Address.

4. After the attack transaction is confirmed, check the target contract's entrant value again - it should be my Address.
    ```bash
    await contract.entrant()
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```
