// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IDiamond} from "diamond/interfaces/IDiamond.sol";

import {ICounter} from "../src/interfaces/ICounter.sol";
import {ICounterApp} from "../src/interfaces/ICounterApp.sol";
import {CounterApp} from "../src/CounterApp.sol";
import {CounterFacet} from "../src/facets/CounterFacet.sol";

contract CounterTest is Test {
    ICounterApp public counter;

    function setUp() public {
        counter = ICounterApp(address(new CounterApp(address(this))));

        CounterFacet counterFacet = new CounterFacet();
        IDiamond.FacetCut[] memory cut = new IDiamond.FacetCut[](1);
        bytes4[] memory functionSelectors = new bytes4[](3);
        functionSelectors[0] = ICounter.number.selector;
        functionSelectors[1] = ICounter.setNumber.selector;
        functionSelectors[2] = ICounter.increment.selector;
        cut[0] = IDiamond.FacetCut({
            facetAddress: address(counterFacet),
            action: IDiamond.FacetCutAction.Add,
            functionSelectors: functionSelectors
        });
        counter.diamondCut(cut, address(0), "");
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
