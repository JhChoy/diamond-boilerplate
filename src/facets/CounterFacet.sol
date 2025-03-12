// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Ownable} from "diamond/Ownable.sol";

import {ICounter} from "../interfaces/ICounter.sol";
import {Count} from "../storages/Count.sol";

contract CounterFacet is ICounter, Ownable {
    function number() public view returns (uint256) {
        Count.Storage storage $ = Count.load();
        return $.number;
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        Count.Storage storage $ = Count.load();
        $.number = newNumber;
    }

    function increment() public {
        Count.Storage storage $ = Count.load();
        $.number++;
    }
}
