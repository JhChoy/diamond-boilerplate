// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {IDiamond} from "diamond/interfaces/IDiamond.sol";

import {ICounter} from "../src/interfaces/ICounter.sol";
import {ICounterApp} from "../src/interfaces/ICounterApp.sol";
import {CounterApp} from "../src/CounterApp.sol";
import {CounterFacet} from "../src/facets/CounterFacet.sol";

contract CounterScript is Script {
    ICounterApp public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

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

        vm.stopBroadcast();
    }
}
