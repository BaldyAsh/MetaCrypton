// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../InventoryStorage.sol";
import "../interfaces/IInventory.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/UpgradeErrors.sol";


contract InventoryEtherUpgrade is
    IUpgrade,
    InventoryStorage
{
    constructor() {
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = address(this);
        _methods[IUpgrade(address(0x00)).getProxyId.selector] = address(this);
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = address(this);
    }

    function applyUpgrade() external override {
        if (msg.sender != address(this)) revert UpgradeErrors.ApplyUpgradeOnlyCallableByItself();
        
        address upgradeAddress = _methods[msg.sig];
        _methods[IInventory(address(0x00)).depositEther.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).withdrawEther.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).getEtherBalance.selector] = upgradeAddress;
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00)
            || interfaceId == type(IUpgrade).interfaceId;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }
}