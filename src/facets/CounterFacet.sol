// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ICounter} from "../interfaces/ICounter.sol";
import {Count} from "../storages/Count.sol";

contract CounterFacet is ICounter {
    function count() public view returns (uint256) {
        Count.Storage storage $ = Count.load();
        return $.count;
    }

    function setNumber(uint256 newNumber) public {
        Count.Storage storage $ = Count.load();
        $.count = newNumber;
    }

    function increment() public {
        Count.Storage storage $ = Count.load();
        $.count++;
    }
}
