// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library Count {
    // bytes32(uint256(keccak256("app.count.storage")) - 1)
    bytes32 internal constant POSITION = 0xa5fda9fb89c617c49017860dffaf5bd4eae18c68bd67ef0728cc763aa4cec4e2;

    struct Storage {
        uint256 number;
    }

    function load() internal pure returns (Storage storage $) {
        assembly {
            $.slot := POSITION
        }
    }
}
