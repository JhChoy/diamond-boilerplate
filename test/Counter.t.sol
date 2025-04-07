// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IDiamond} from "diamond/interfaces/IDiamond.sol";
import {DiamondScript} from "diamond/helpers/DiamondScript.sol";
import {Ownable} from "diamond/Ownable.sol";

import {ICounter} from "../src/interfaces/ICounter.sol";
import {ICounterApp} from "../src/interfaces/ICounterApp.sol";
import {CounterApp} from "../src/CounterApp.sol";
import {CounterFacet} from "../src/facets/CounterFacet.sol";

contract CounterTest is Test, DiamondScript("CounterApp") {
    string[] facetNames;
    bytes[] facetArgs;

    ICounterApp counter;

    function setUp() public {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        counter = ICounterApp(
            deploy(abi.encode(address(this)), bytes32(0), facetNames, facetArgs, address(0), "", false).diamond
        );

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

    function test_SetNumber_OnlyOwner() public {
        vm.prank(address(1));
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, address(1)));
        counter.setNumber(1);
    }
}
