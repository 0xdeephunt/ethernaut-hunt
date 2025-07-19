# Level 7: Force

### Wargame
The goal of this level is to make the balance of the contract greater than zero.

### Key Insights
* selfdestruct
* A contract can force send ETH to another contract (even if the receiving contract doesn't have a payable receive() or fallback() function) by self-destructing. This is often referred to as a "griefing" or "force sending" attack/technique.

### Attack Steps
1. Deploy ForceAttck.sol contract and transfer 0.01 ETHs to it. Its address is "0x1A4d7f74504b26ac946279F184b7288bFABa48aA".

2. Before executing the attack, display the current balance of the target contract.
    ```bash
    > await getBalance(instance)
    '0'

    > await getBalance("0x1A4d7f74504b26ac946279F184b7288bFABa48aA")
    '0.001'
    ```
3. Call attack() of ForceAttck.

4. After the transaction is confirmed, display the balance of the target contract again. You will now observe that the contract's balance has been successfully changed to 0.01, demonstrating the success of the attack. 
    ```bash
    > await getBalance(instance)
    '0.001'

    > await getBalance("0x1A4d7f74504b26ac946279F184b7288bFABa48aA")
    '0'
    ```
