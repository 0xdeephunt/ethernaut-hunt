# Level 27: Good Samaritan

## Wargame
Would you be able to drain all the balance from his Wallet?

## Key Insights
- **Custom Errors**:  
  Solidity allows defining custom error types, which can then be used to revert a transaction.  
  Custom errors only pass a 4-byte selector and encoded parameters, making them cheaper than `require` messages.

## Attack Steps

### 1. Instance Address
```bash
0x55711295A6c1f28eCd453A890F7425B0e155ED2f
```

### 2. Deploy Attack Contract
- Deploy the `GoodSamaritanAttack` contract, passing the target contract address as a constructor argument.
- Call `myBalance()` — the returned value should be `0`.

### 3. Execute the Attack
- Call the `attack()` function from the `GoodSamaritanAttack` contract.
- Call `myBalance()` again — the returned value should now be `1000000`.