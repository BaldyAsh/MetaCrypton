// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./IUpgradesRegistryEvents.sol";
import "./IUpgradesRegistryProxies.sol";
import "./IUpgradesRegistryUpgrades.sol";

interface IUpgradesRegistry is
    IUpgradesRegistryEvents,
    IUpgradesRegistryProxies,
    IUpgradesRegistryUpgrades
{ }
