# Level 29: Switch

## Wargame
Just have to flip the switch. 

## Key Insights
- calldata

## Attack Steps

### 1. Check target contract
- Instance Address
    ```
    0xC30451a1Ea07690f9e8D15E2f43535e1Afc558c1
    ```

- Initial State Checks
    ```javascript
    await contract.switchOn()
    //false
    ```

### 2. Deploy Attack Contract
Deploy the `SwitchAttck` contract.

### 3. Execute the Attack
- Call `attack()` function from SwitchAttck, passing the target contract address.
- State Checks
    ```javascript
    await contract.switchOn()
    ///true
    ```

### Appendix: Calldata Diagram
- Show how to make flipSwitch() call turnSwitchOn():
    ```
    ┌───────────────────────────┐
    │  Function Selector (4B)   │  // keccak256("flipSwitch(bytes)")[:4]
    │  (Offset 0)               │
    ├───────────────────────────┤
    │  _data Offset (32B)       │  // 0x60 → points to absolute offset 100
    │  (Offset 4)               │
    ├───────────────────────────┤
    │  Padding (32B)            │  // unused / filler
    │  (Offset 36)              │
    ├───────────────────────────┤
    │  offSelector (4B)         │  // placed here to satisfy onlyOff()
    │  (Offset 68)              │
    │  Padding (28B)            │
    │  (Offset 72..99)          │
    ├───────────────────────────┤
    │  _data Length (32B)       │  // 0x04
    │  (Offset 100)             │
    ├───────────────────────────┤
    │  _data Content (4B)       │  // onSelector = keccak256("turnSwitchOn()")[:4]
    │  (Offset 132)             │
    │  Padding (28B)            │
    │  (Offset 136..163)        │
    └───────────────────────────┘
    ```