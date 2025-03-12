// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IDiamondApp} from "diamond/interfaces/IDiamondApp.sol";
import {ICounter} from "./ICounter.sol";

interface ICounterApp is IDiamondApp, ICounter {}
