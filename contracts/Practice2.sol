// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IDataStructurePractice {
    struct User {
        string name;
        uint256 balance;
        bool isActive;
    }

    function setNewUser(address _userAdr, User calldata _newUser) external;

    function getUser(address _user) external view returns (User memory);

    function getMyInfo() external view returns (User memory);
}

contract Practice2 is IDataStructurePractice, Ownable {
    mapping(address => User) internal _users;

    function setNewUser(address _userAdr, User calldata _newUser) external onlyOwner {
        _users[_userAdr] = _newUser;
    }

    function getUser(address _address) external view returns (User memory) {
        return _users[_address];
    }

    function getMyInfo() external view returns (User memory) {
        return _users[msg.sender];
    }
}
