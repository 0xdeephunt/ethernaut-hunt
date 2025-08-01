# Level 20: Denial

### Wargame
If you can deny the owner from withdrawing funds when they call withdraw() (whilst the contract still has funds, and the transaction is of 1M gas or less) you will win this level.

### Key Insights
* gas

### Attack Steps
1. Before executing the attack, display the address of the target contract.
    ```bash
    > instance
    '0xfCF2505b05Ec71B931b51AC45D57b704e3DC5374'

    > banlance = await contract.contractBalance()
    > fromWei(banlance)
    '0.001'

    > await contract.partner()
    '0x0000000000000000000000000000000000000000'
    ```

2. Deploy the DenialAttack contract. Its receive() function is designed to consume gas indefinitely.

3. Call attack() from the DenialAttack contract.

4. After the transaction is confirmed, check whether the partner address has been changed:
    ```bash
    await contract.partner()
    '0xC062c1574550f7435Dfc4bA8648A0aE754d062B8'
    ```

5. Submit this level on Ethernaut.