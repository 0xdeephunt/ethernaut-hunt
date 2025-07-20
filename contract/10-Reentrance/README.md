# Level 10: Reentrance

### Wargame
The goal of this level is for you to steal all the funds from the contract.

### Key Insights
* receive()
* The withdraw() function sends ETH to an external contract, which invokes its receive() function. If the external contract is malicious, it may re-enter withdraw() before the first call completes, enabling a reentrancy attack.

### Attack Steps
1. Display Target Contract Balance

    Before executing the attack, retrieve and display the balance of the target contract to confirm it holds ETH.
    ```bash
    > instance
    '0xD20d3fD0AE3F4d9424431b54300B01171780f3bA'

    > await web3.eth.getBalance("0xD20d3fD0AE3F4d9424431b54300B01171780f3bA")
    '1000000000000000'
    ```

2. Donate ETH to Target via toDonate()

    Call the toDonate() function of the ReentranceAttack contract. This sends a small amount of ETH to the target contract, registering the attacker as a donor and enabling future withdrawal.
    ```bash
    > await web3.eth.getBalance("0xD20d3fD0AE3F4d9424431b54300B01171780f3bA")
    '2000000000000000'

    > myBalance = await contract.balanceOf("0x0DCC0fb8C1376343cB8A91aC471E35975b7D9512")
    > fromWei(myBalance)
    '0.001'
    ```

3. Execute the Attack via attack()

    Call the attack() function of the ReentranceAttack contract. This triggers the reentrancy exploit by recursively calling the vulnerable withdraw() function of the target contract.

4. Confirm Target Drained

    After the attack transaction is confirmed, check the target contract’s balance again—it should be zero, indicating that all ETH has been drained.
    ```bash
    > await web3.eth.getBalance("0xD20d3fD0AE3F4d9424431b54300B01171780f3bA")
    '0'

    > await web3.eth.getBalance("0x0DCC0fb8C1376343cB8A91aC471E35975b7D9512")
    '2000000000000000'
    ```