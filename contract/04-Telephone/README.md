# Level 4: Telephone

### Wargame

Claim ownership of the contract below to complete this level.

### Key Insights
* Q: Under what conditions are tx.origin and msg.sender not equal?
* A: When a wallet calls a contract, that contract then calls another target contract.

### Attack Steps
1. On the Ethernaut web page, enter the develp tool console.
Run "contract.address" or "instance" to display the Telephone contract address.
    ```bash
    > contract.address
    '0x1769d2C91D250EBF2ce18f1d986FE8B015d2a173'
    ```

2. On Remix IDE. 
Compile the contract TelephoneAttach.sol.

3. On Remix IDE. 
Set the WalletConnect to ENVIRONMENT and select Sepolia on the MetaMask. To do this, deploy the TelephoneAttach.sol contract.

4. On the Ethernaut web page, enter the develp tool console.
Confirm that the owner of the contract is my MeteMask address.
    ```bash
    > await contract.owner()
    '0xEB...Ff'
    ```
