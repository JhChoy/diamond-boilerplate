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

    function deploy() public {
        vm.startBroadcast();

        facetNames.push("CounterFacet");
        facetArgs.push("");

        (address diamond,) = deployAndSave(abi.encode(address(this)), facetNames, facetArgs);
        counter = ICounterApp(diamond);

        vm.stopBroadcast();
    }
}
