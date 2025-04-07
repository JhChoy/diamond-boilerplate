// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {IDiamond} from "diamond/interfaces/IDiamond.sol";
import {DiamondScript} from "diamond/helpers/DiamondScript.sol";
import {ICounter} from "../src/interfaces/ICounter.sol";
import {ICounterApp} from "../src/interfaces/ICounterApp.sol";
import {CounterApp} from "../src/CounterApp.sol";
import {CounterFacet} from "../src/facets/CounterFacet.sol";

contract CounterScript is DiamondScript("CounterApp") {
    string[] facetNames;
    bytes[] facetArgs;

    bytes32 salt = bytes32(0);
    ICounterApp counter;

    function setUp() public {}

    function deploy() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        counter = ICounterApp(deploy(abi.encode(msg.sender), salt, facetNames, facetArgs, address(0), "").diamond);
    }

    function upgrade() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        upgrade(facetNames, facetArgs, address(0), "");
    }
}
