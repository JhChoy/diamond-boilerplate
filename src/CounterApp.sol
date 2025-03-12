// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {DiamondApp} from "diamond/DiamondApp.sol";

contract CounterApp is DiamondApp {
    constructor(address _owner) DiamondApp(_owner) {}
}
