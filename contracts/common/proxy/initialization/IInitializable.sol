// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInitializable {
    function initialize(bytes calldata input) external;
}