# Level 25: Motorbike

## Wargame
Would you be able to selfdestruct its engine and make the motorbike unusable ?

## Notes
After the Ethereum Cancún upgrade (EIP-6780), once a contract has been deployed (the creation transaction has completed), it can no longer be truly destroyed.  
Therefore, the original completion condition of this level can no longer be met on upgraded networks like current Sepolia or mainnet.


## Key Insights
- **delegatecall**: Executes code in the context of another contract's storage.
- **selfdestruct**: Used in the original exploit to delete contract bytecode, but now only transfers ETH and does not remove code unless called in the same transaction as deployment (per EIP-6780).


## Attack Steps

### 1. Inspect the target contractinstance
* The storage slot reveals the address of the logic (Engine) contract used by the proxy.
    ```javascript
    '0x3DD7e65721Eb1F6912DB3FFb4b5F565B040e3096'

    const slot = '0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc'
    await web3.eth.getStorageAt(instance, slot);
    // '0x000000000000000000000000c757bdd3a983c8918019c72afabbb75a41f48d3f'

    const logicAddress = '0xc757bdd3a983c8918019c72afabbb75a41f48d3f'
    await web3.eth.getStorageAt(logicAddress, 0);
    // '0x0000000000000000000000000000000000000000000000000000000000000000'
    ```

### 2. Deploy the attack contract
* Deploy MotorbikeAttack contract. This deployed address:
    ```
    0x18ad6eA851111EEfa94e585382220f3cdBEF069D
    ```

### 3. Prepare for the attack
* Call attackPrepare() on MotorbikeAttack, passing the logic contract address (0xc757bdd3a983c8918019c72afabbb75a41f48d3f):
    ```javascript
    await web3.eth.getStorageAt(logicAddress, 0);
    // '0x0000000000000000000018ad6ea851111eefa94e585382220f3cdbef069d0001'
    ```
* This step sets the upgrader to the attack contract, allowing control over the upgrade mechanism.

### 4. Execute the attack
* Call attack() on MotorbikeAttack, passing the logic contract address again. This triggers the upgradeToAndCall function via delegatecall, which in turn attempts to execute selfdestruct in the logic contract’s context.

Originally (pre-EIP-6780), this would:
* Remove the logic contract’s bytecode from the blockchain.
* Cause getCode(logicAddress) to return 0x, satisfying the level’s check.

However, post-EIP-6780:
* selfdestruct only transfers ETH and does not delete code for already-deployed contracts.
* The logic contract remains intact, and the level cannot be completed on current networks.











