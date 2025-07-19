# Level 9: King

### Wargame
When you submit the instance back to the level, the level is going to reclaim kingship. You will beat the level if you can avoid such a self proclamation.

### Key Insights
* Do not define a receive() or fallback() function to prevent other contracts from sending Ether.

### Attack Steps
1. Before executing the attack, display the king value of the target contract.
    ```bash
    > instance
    '0x7d5509fd1B5f964812f22e281eC2BB1eAB5801D9'

    > prize = await contract.prize()
    > fromWei(prize)
    '0.001'

    > await contract._king()
    '0x3049C00639E6dfC269ED1451764a046f7aE500c6'

2. Call the function attack() of KingAttack to attack the contract king.

3. After the transaction is confirmed, the king value of the target contract is the contract address of KingAttack.
    ```bash
    > await contract._king()
    '0x7f00DCb149CBf93f7B058C74b4290Fc7E9d9F86a'
    ```
