// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../InventoryStorage.sol";

library InventoryEternalStorageCommon {
    function _setUint(
        EternalStorage storage eternalStorage,
        bytes32 key,
        uint value
    ) internal {
        eternalStorage.uints[key] = value;
    }

    function _setInt(
        EternalStorage storage eternalStorage,
        bytes32 key,
        int value
    ) internal {
        eternalStorage.ints[key] = value;
    }

    function _setAddress(
        EternalStorage storage eternalStorage,
        bytes32 key,
        address value
    ) internal {
        eternalStorage.addresses[key] = value;
    }

    function _setBytes32(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bytes32 value
    ) internal {
        eternalStorage.bytes32s[key] = value;
    }

    function _setBool(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bool value
    ) internal {
        eternalStorage.bools[key] = value;
    }

    function _setBytes(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bytes memory value
    ) internal {
        eternalStorage.bytesValues[key] = value;
    }

    function _setUintArray(
        EternalStorage storage eternalStorage,
        bytes32 key,
        uint[] memory value
    ) internal {
        eternalStorage.uintArrays[key] = value;
    }

    function _setIntArray(
        EternalStorage storage eternalStorage,
        bytes32 key,
        int[] memory value
    ) internal {
        eternalStorage.intArrays[key] = value;
    }

    function _setAddressArray(
        EternalStorage storage eternalStorage,
        bytes32 key,
        address[] memory value
    ) internal {
        eternalStorage.addressArrays[key] = value;
    }

    function _setBytes32Array(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bytes32[] memory value
    ) internal {
        eternalStorage.bytes32Arrays[key] = value;
    }

    function _setBoolArray(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bool[] memory value
    ) internal {
        eternalStorage.boolArrays[key] = value;
    }

    function _setBytesArray(
        EternalStorage storage eternalStorage,
        bytes32 key,
        bytes[] memory value
    ) internal {
        eternalStorage.bytesArrays[key] = value;
    }

    function _removeUint(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.uints[key];
    }

    function _removeInt(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.ints[key];
    }

    function _removeAddress(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.addresses[key];
    }

    function _removeBytes32(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.bytes32s[key];
    }

    function _removeBool(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.bools[key];
    }

    function _removeBytes(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.bytesValues[key];
    }

    function _removeUintArray(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.uintArrays[key];
    }

    function _removeIntArray(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.intArrays[key];
    }

    function _removeAddressArray(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.addressArrays[key];
    }

    function _removeBytes32Array(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.bytes32Arrays[key];
    }

    function _removeBoolArray(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.boolArrays[key];
    }

    function _removeBytesArray(EternalStorage storage eternalStorage, bytes32 key) internal {
        delete eternalStorage.bytesArrays[key];
    }

    function _getUint(EternalStorage storage eternalStorage, bytes32 key) public view returns (uint) {
        return eternalStorage.uints[key];
    }

    function getInt(EternalStorage storage eternalStorage, bytes32 key) public view returns (int) {
        return eternalStorage.ints[key];
    }

    function getAddress(EternalStorage storage eternalStorage, bytes32 key) public view returns (address) {
        return eternalStorage.addresses[key];
    }

    function getBytes32(EternalStorage storage eternalStorage, bytes32 key) public view returns (bytes32) {
        return eternalStorage.bytes32s[key];
    }

    function getBool(EternalStorage storage eternalStorage, bytes32 key) public view returns (bool) {
        return eternalStorage.bools[key];
    }

    function getBytes(EternalStorage storage eternalStorage, bytes32 key) public view returns (bytes memory) {
        return eternalStorage.bytesValues[key];
    }

    function getUintArray(EternalStorage storage eternalStorage, bytes32 key) public view returns (uint[] memory) {
        return eternalStorage.uintArrays[key];
    }

    function getIntArray(EternalStorage storage eternalStorage, bytes32 key) public view returns (int[] memory) {
        return eternalStorage.intArrays[key];
    }

    function getAddressArray(EternalStorage storage eternalStorage, bytes32 key) public view returns (address[] memory) {
        return eternalStorage.addressArrays[key];
    }

    function getBytes32Array(EternalStorage storage eternalStorage, bytes32 key) public view returns (bytes32[] memory) {
        return eternalStorage.bytes32Arrays[key];
    }

    function getBoolArray(EternalStorage storage eternalStorage, bytes32 key) public view returns (bool[] memory) {
        return eternalStorage.boolArrays[key];
    }

    function getBytesArray(EternalStorage storage eternalStorage, bytes32 key) public view returns (bytes[] memory) {
        return eternalStorage.bytesArrays[key];
    }
}
