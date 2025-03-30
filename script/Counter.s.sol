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

    ICounterApp counter;

    function setUp() public {}

    function deploy() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        counter = ICounterApp(deployAndSave(abi.encode(msg.sender), facetNames, facetArgs).diamond);
    }

    function upgrade() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        upgradeToAndSave(facetNames, facetArgs);
    }
}
