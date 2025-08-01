# Level 21: Shop

### Wargame
Сan you get the item from the shop for less than the price asked?

### Key Insights
* view function

### Attack Steps
1. Before launching the attack, retrieve and display the address of the target contract and check its current state:
    ```bash
    > instance
    '0xFc64Db46efEEAfcAbe2B490Cf600B081a719EFD8'

    > price = await contract.price()
    > price.toString()
    '100'
    ```

2. Deploy ShopAttack contract.
* Its price() function is designed to return different values depending on the isSold state of the target contract.
* This allows you to manipulate the logic inside the vulnerable Shop contract.

3. Call the attack() function from the ShopAttack contract.
* This will trigger the target contract to purchase the item at a manipulated price.

4. Once the transaction is confirmed, check whether the price value in the Shop contract has been successfully changed:
    ```bash
    > price = await contract.price()
    > price.toString()
    '99'
    ```

5. Submit the Level.