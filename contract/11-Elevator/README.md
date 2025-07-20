# Level 11: Elevator

### Wargame
This elevator won't let you reach the top of your building. Right?

### Key Insights
* State Dependency Attack
* Non-Idempotent function
* A State Dependency Attack based on a Non-Idempotent Function exploits changing internal state to produce different outcomes from repeated calls with the same input

### Attack Steps
1. Deploy Building Contract

    Deploy the Building contract, which implements the isLastFloor(uint) interface.
    ```bash
    > instance
    '0x6Ca8D04981dD588D70B13D26Ad02B23f3974fDB3'

    >await contract.top()
    false
    ```

2. Call attack() with Target Address

    Invoke attack(), which calls the target contract's goTo(ATTACK_FLOOR).

3. Result

    The Elevator contract is misled into setting top = true, passing the challenge logic.
    ```bash
    > await contract.top()
    true
    ```
