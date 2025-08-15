# Level 28: Gatekeeper Three

## Wargame
Cope with gates and become an entrant.


## Attack Steps

### 1. Check target contract
- Instance Address
    ```
    0x04E91b7b47B450eA7453569e30772A01fd855495
    ```

- Initial State Checks
    ```javascript
    getBalance(instance)
    //'0'

    contract.owner()
    //'0x0000000000000000000000000000000000000000'

    contract.allowEntrance()
    //false

    contract.entrant()
    //'0x0000000000000000000000000000000000000000'
    ```

### 2. Deploy Attack Contract
Deploy the `GatekeeperThreeAttack` contract, passing the target contract address in the constructor.

### 3. Execute the Attack
- call `attackPrepare()` function from GatekeeperThreeAttack:
    ```javascript
    contract.owner()
    //'0x8024e0BFE7C0bdcaBA7fC716A186f17E9bF6E793'

    contract.allowEntrance()
    //true

    await getBalance(instance)
    //'0.002'
    ```

- call the `attack()` function from GatekeeperThreeAttack:
    ```javascript
    contract.entrant()
    //'0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```