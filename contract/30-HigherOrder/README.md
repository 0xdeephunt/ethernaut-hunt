# Level 30: HigherOrder

## Wargame
Your objective is to become the Commander of the Higher Order! 

## Key Insights
- calldata

## Attack Steps

### 1. Check target contract
- Instance Address
    ```
    0x69746a83D6149a39E009AC2ad4F58cB4EDc6526D
    ```

- Initial State Checks
    ```javascript
    await contract.treasury()
    //0

    await contract.commander()
    //'0x0000000000000000000000000000000000000000'
    ```

### 2. Deploy Attack Contract
Deploy the `HigherOrderAttack` contract.

### 3. Execute the Attack
- Call `attack()` function from HigherOrderAttack, passing the target contract address.

- The value of treasury beyond 255.
    ```javascript
    await contract.treasury()
    //256
    ```

- Run the `claimLeadership()` to become the Commander of the Higher Order.
    ```javascript
    await contract.claimLeadership()

    await contract.commander()
    //'0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```