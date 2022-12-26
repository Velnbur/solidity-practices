// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

interface IDataTypesPractice {
    function getInt256() external view returns (int256);

    function getUint256() external view returns (uint256);

    function getIint8() external view returns (int8);

    function getUint8() external view returns (uint8);

    function getBool() external view returns (bool);

    function getAddress() external view returns (address);

    function getBytes32() external view returns (bytes32);

    function getArrayUint5() external view returns (uint256[5] memory);

    function getArrayUint() external view returns (uint256[] memory);

    function getString() external view returns (string memory);

    function getBigUint() external pure returns (uint256);
}

contract Practice1 is IDataTypesPractice {
    int256 signedNum = -123123;

    uint256 unsignedNum = 111111;

    int8 smallNum = 120;

    uint8 smallUnsignedNum = 255;

    bool isTrue = true;

    address someAddress = 0xd35c0a2d081493467196A01769B63616F8D8805f;

    bytes32 someBytes = "some bytes";

    uint256[5] numbersArray = [1, 2, 3, 4, 5];

    uint256[] numbers = new uint256[](10);

    string helloWorld = "Hello World!";

    function getInt256() external view returns (int256) {
        return signedNum;
    }

    function getUint256() external view returns (uint256) {
        return unsignedNum;
    }

    function getIint8() external view returns (int8) {
        return smallNum;
    }

    function getUint8() external view returns (uint8) {
        return smallUnsignedNum;
    }

    function getBool() external view returns (bool) {
        return isTrue;
    }

    function getAddress() external view returns (address) {
        return someAddress;
    }

    function getBytes32() external view returns (bytes32) {
        return someBytes;
    }

    function getArrayUint5() external view returns (uint256[5] memory) {
        return numbersArray;
    }

    function getArrayUint() external view returns (uint256[] memory) {
        return numbers;
    }

    function getString() external view returns (string memory) {
        return helloWorld;
    }

    function getBigUint() external pure returns (uint256) {
        uint256 v1 = 1;
        uint256 v2 = 2;

        return ~v2 + v1; // inverts all bits
    }
}
