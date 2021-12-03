// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitErrors.sol";
import "../UpgradesRegistryStorage.sol";
import "../../common/interfaces/upgradability/IUpgrade.sol";
import "../../common/interfaces/upgradability/IUpgradable.sol";

contract UpgradesRegistryInitCommon is UpgradesRegistryStorage {
    function _registerProxy(address proxyAddress) internal returns (bytes32) {
        _verifyIUpgradableInterface(proxyAddress);

        bytes32 proxyId = IUpgrade(proxyAddress).getProxyId();
        _storeProxy(proxyId, proxyAddress);

        return proxyId;
    }

    function _registerUpgrade(address upgradeAddress) internal returns (bytes32, uint256) {
        _verifyIUpgradeInterface(upgradeAddress);

        bytes32 proxyId = IUpgrade(upgradeAddress).getProxyId();
        uint256 upgradeIndex = _storeUpgrade(proxyId, upgradeAddress);

        return (proxyId, upgradeIndex);
    }

    function _storeProxy(bytes32 proxyId, address proxyAddress) internal {
        _verifyProxyInput(proxyId, proxyAddress);

        StoredProxy storage proxy = _proxies[proxyAddress];

        _verifyUnexistingProxy(proxy);
        _verifyProxyHasUpgrades(proxyId);

        uint256[] memory currentUpgradesList = new uint256[](1);
        currentUpgradesList[0] = 0;

        proxy.proxyId = proxyId;
        proxy.currentUpgradesList = currentUpgradesList;
    }

    function _storeUpgrade(bytes32 proxyId, address upgradeAddress) internal returns (uint256) {
        _verifyUpgradeInput(proxyId, upgradeAddress);
        
        Upgrades storage upgrades = _upgrades[proxyId];
        _verifyUnexistingUpgrade(upgrades, upgradeAddress);

        upgrades.upgradesAddresses.push(upgradeAddress);

        uint upgradeIndex = upgrades.upgradesAddresses.length - 1;
        upgrades.upgradesIndexes[upgradeAddress] = upgradeIndex;

        return upgradeIndex;
    }

    function _upgradeProxy(address proxyAddress, uint256 upgradeIndex) internal returns (address) {
        bytes32 proxyId = _getProxyId(proxyAddress);

        Upgrades storage upgrades = _upgrades[proxyId];
        _verifyExistingUpgrade(upgrades, upgradeIndex);

        StoredProxy storage proxy = _proxies[proxyAddress];
        _verifyUpgradeNotApplied(proxy, upgradeIndex);

        proxy.currentUpgradesList.push(upgradeIndex);
        
        return upgrades.upgradesAddresses[upgradeIndex];
    }

    function _verifyUnexistingUpgrade(Upgrades storage upgrades, address upgradeAddress) internal view {
        uint256 length = upgrades.upgradesAddresses.length;
        for (uint256 i = 0; i < length; i++) {
            if (upgrades.upgradesAddresses[i] == upgradeAddress) revert UpgradesRegistryInitErrors.ExistingUpgrade();
        }
    }

    function _getCurrentUpgrades(address proxyAddress) internal view returns (uint256[] memory) {
        return _proxies[proxyAddress].currentUpgradesList;
    }

    function _getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) internal view returns (uint) {
        Upgrades storage upgrades = _upgrades[proxyId];
        uint256 length = upgrades.upgradesAddresses.length;
        if (length == 0) revert UpgradesRegistryInitErrors.NoUpgrades();

        return length - 1;
    }

    function _getProxyId(address proxyAddress) internal view returns (bytes32) {
        bytes32 proxyId = _proxies[proxyAddress].proxyId;
        if (proxyId == bytes32(0x00)) revert UpgradesRegistryInitErrors.UnexistingProxy();
        return proxyId;
    }

    function _isProxyRegistered(address proxyAddress) internal view returns (bool) {
        return _proxies[proxyAddress].proxyId != bytes32(0x00);
    }

    function _verifyUnexistingProxy(StoredProxy storage proxy) internal view {
        if (proxy.proxyId != bytes32(0x00)) revert UpgradesRegistryInitErrors.ExistingProxy();
    }

    function _verifyProxyHasUpgrades(bytes32 proxyId) internal view {
        if (_upgrades[proxyId].upgradesAddresses.length == 0) revert UpgradesRegistryInitErrors.UnexistingInitUpgrade();
    }

    function _verifyExistingUpgrade(Upgrades storage upgrades, uint256 upgradeIndex) internal view {
        if (upgrades.upgradesAddresses.length <= upgradeIndex) revert UpgradesRegistryInitErrors.UnexistingUpgrade();
    }

    function _verifyUpgradeNotApplied(StoredProxy storage proxy, uint256 upgradeIndex) internal view {
        uint256 length = proxy.currentUpgradesList.length;
        for (uint256 i = 0; i < length; i++) {
            if (proxy.currentUpgradesList[i] == upgradeIndex) revert UpgradesRegistryInitErrors.UpgradeApplied();
        }
    }

    function _verifyIUpgradableInterface(address componentAddress) internal view {
        if (!IERC165(componentAddress).supportsInterface(IUpgradable.upgrade.selector)) revert UpgradesRegistryInitErrors.NoUpgradeMethod();
        if (!IERC165(componentAddress).supportsInterface(IUpgradable.getCurrentUpgrades.selector)) revert UpgradesRegistryInitErrors.NoGetCurrentUpgradesMethod();
        if (!IERC165(componentAddress).supportsInterface(IUpgradable.getMaxPossibleUpgradeIndex.selector)) revert UpgradesRegistryInitErrors.NoGetMaxPossibleUpgradeIndexMethod();
    }

    function _verifyIUpgradeInterface(address componentAddress) internal view {
        if (!IERC165(componentAddress).supportsInterface(IUpgrade.applyUpgrade.selector)) revert UpgradesRegistryInitErrors.NoApplyUpgradeMethod();
        if (!IERC165(componentAddress).supportsInterface(IUpgrade.getProxyId.selector)) revert UpgradesRegistryInitErrors.NoGetProxyIdMethod();
    }

    function _verifyProxyInput(bytes32 proxyId, address proxyAddress) internal pure {
        if (proxyId == bytes32(0x00)) revert UpgradesRegistryInitErrors.EmptyProxyId();
        if (proxyAddress == address(0x00)) revert UpgradesRegistryInitErrors.EmptyProxyAddress();
    }

    function _verifyUpgradeInput(bytes32 proxyId, address upgradeAddress) internal pure {
        if (proxyId == bytes32(0x00)) revert UpgradesRegistryInitErrors.EmptyProxyId();
        if (upgradeAddress == address(0x00)) revert UpgradesRegistryInitErrors.EmptyUpgradeAddress();
    }
}