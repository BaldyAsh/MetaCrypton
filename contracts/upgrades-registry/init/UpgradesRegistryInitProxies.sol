// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../interfaces/IUpgradesRegistryProxies.sol";
import "../interfaces/IUpgradesRegistryEvents.sol";
import "../../common/governance/Governable.sol";

contract UpgradesRegistryInitProxies is
    IUpgradesRegistryProxies,
    IUpgradesRegistryEvents,
    Governable,
    UpgradesRegistryInitCommon
{
    function registerProxy(address proxyAddress) external override isGovernance {
        bytes32 proxyId = _registerProxy(proxyAddress);

        emit ProxyRegistered(proxyId, proxyAddress);
    }

    function getProxyId(address proxyAddress) external view override returns (bytes32) {
        return _getProxyId(proxyAddress);
    }

    function isProxyRegistered(address proxyAddress) external view override returns (bool) {
        return _isProxyRegistered(proxyAddress);
    }
}
