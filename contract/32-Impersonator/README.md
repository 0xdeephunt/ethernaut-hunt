# Level 32: Impersonator

## Wargame
Can you compromise the system in a way that anyone can open the door?

## Key Insights
- signature
- ecrecover

## Attack Steps

### 1. Target Contract Address
```
0xBc45f4aA77ead2D99f4FFfbdA8b37f185e607e0A
```

### 2. Inspect Contract Events
View the contract events on Sepolia Etherscan:  
[Contract Events](https://sepolia.etherscan.io/address/0xBc45f4aA77ead2D99f4FFfbdA8b37f185e607e0A#events)

From the logs, retrieve the `signature` values. These values allow us to extract the `v`, `r`, and `s` components needed for the attack.

### 3. Deploy Attack Contract
Deploy the ImpersonatorAttack contract, passing the target contract address.

### 4. Execute the Attack
Call the function `attack()` with the extracted signature values to replace the controller with the 0 address.
- `v`: 0x1b
- `r`: 0x1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91
- `s`: 0x78489c64a0db16c40ef986beccc8f069ad5041e5b992d76fe76bba057d9abff2

## 5. Verify Contract State
After executing `attack()`, you can verify the state of the `ECLocker` contract here:  
[Contract State](https://sepolia.etherscan.io/address/0x8376cBEf46DEd0b688fa56EBA780294d94813A6b#readContract)


## 6. Test the Attack
Finally, call `test()` with any valid `v`, `r`, `s` values.  
This will successfully trigger the `emit Open()` event, confirming the attack.
