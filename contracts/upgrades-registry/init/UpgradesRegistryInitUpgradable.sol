// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../../common/governance/Governable.sol";
import "../../common/upgradability/IUpgradable.sol";
import "../../common/upgradability/IUpgrade.sol";

contract UpgradesRegistryInitUpgradable is
    IUpgradable,
    Governable,
    UpgradesRegistryInitCommon
{
    function upgrade(uint256 upgradeIndex) external override isGovernance {
        address upgradeAddress = _upgradeProxy(address(this), upgradeIndex);
        bytes4 selector = IUpgrade(address(0x00)).applyUpgrade.selector;

        _methods[selector] = upgradeAddress;
        IUpgrade(address(this)).applyUpgrade();
        delete _methods[selector];
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory) {
        return _getCurrentUpgrades(address(this));
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256) {
        return _getProxyMaxPossibleUpgradeIndex(PROXY_ID);
    }
}
