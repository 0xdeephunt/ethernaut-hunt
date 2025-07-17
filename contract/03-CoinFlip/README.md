# Level 3: CoinFlip

### Wargame

This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.

### Key Insights
* Pseudorandom number
* blockhash is a pseudorandom number in Solidity, not a truly random one. While it appears to be random, it's actually a deterministic value that is highly predictable and can be manipulated.

### Attack Steps
1. On the Ethernaut web page, enter the develp tool console.
Run "contract.address" or "instance" to display the CoinFlip contract instance address.
    ```bash
    > contract.address
    '0x6113Ee6c0B9276D7C929425D22f6C2e79C6fF293'
    ```

2. On Remix IDE. 
Compile the contract CoinFlipAttack.sol.

3. On Remix IDE. 
Set the WalletConnect to ENVIRONMENT and select Sepolia on the MetaMask. To do this, deploy the CoinFlipAttack.sol contract.

3. On Remix IDE. 
For the deployed contracts, I will call the attack function with the parameter '0x6113Ee6c0B9276D7C929425D22f6C2e79C6fF293'. This will help me to correctly guess the value of the CoinFlip contract.
