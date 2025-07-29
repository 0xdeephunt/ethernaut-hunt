// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// To explain the function of bytecode "602a60005260206000f3," you do not need to compile this contract.
// contract Solver {
//     function whatIsTheMeaningOfLife() public pure returns (uint256) {
//         return 42;
//     }
// }

interface ISolver {
    function whatIsTheMeaningOfLife() external pure returns (uint256);
}

contract MagicNumAttack {
    address public contractAddress;
    uint256 public meaningOfLife;

    // To deploy the bytecode of attack contract.
    // bytecode: "602a60005260206000f3"
    function attackPrepare(bytes memory _bytecode) public {
        address addr;

        // create(value, offset, size)
        // value: 0
        // offset: Start of memory for _bytecode
        // size: Length of _bytecode
        assembly {
            addr := create(0, add(_bytecode, 0x20), mload(_bytecode))
        }

        require(addr != address(0), "Deployment failed");
        contractAddress = addr;
    }

    function attack(address _tagetAddress) public {
        bytes memory payload = abi.encodeWithSignature(
            "setSolver(address)",
            contractAddress
        );

        (bool success, ) = _tagetAddress.call(payload);
        require(success);
    }

    function test() public {
        ISolver solver = ISolver(contractAddress);
        meaningOfLife = solver.whatIsTheMeaningOfLife();
    }
}
