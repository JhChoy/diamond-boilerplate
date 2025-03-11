// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ICounter {
    function number() external view returns (uint256);
    function setNumber(uint256 newNumber) external;
    function increment() external;
}
