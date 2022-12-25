// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IMemoryTypesPractice {
    function setA(uint256 _a) external;

    function setB(uint256 _b) external;

    function setC(uint256 _c) external;

    function calc1() external view returns (uint256);

    function calc2() external view returns (uint256);

    function claimRewards(address _user) external;

    function addNewMan(
        uint256 _edge,
        uint8 _dickSize,
        bytes32 _idOfSecretBluetoothVacinationChip,
        uint32 _iq
    ) external;

    function getMiddleDickSize() external view returns (uint256);

    function numberOfOldMenWithHighIq() external view returns (uint256);
}

contract MemoryTypesPracticeInput is IMemoryTypesPractice, Ownable {
    // Owner part. Cannot be modified.
    IUserInfo public userInfo;
    uint256 public a;
    uint256 public b;
    uint256 public c;

    uint256 public constant MIN_BALANCE = 12000;

    mapping(address => bool) public rewardsClaimed;

    constructor(address _validator, address _userInfo) {
        transferOwnership(_validator);
        userInfo = IUserInfo(_userInfo);

        addNewMan(1, 1, bytes32("0x11"), 1);
    }

    function setA(uint256 _a) external onlyOwner {
        a = _a;
    }

    function setB(uint256 _b) external onlyOwner {
        b = _b;
    }

    function setC(uint256 _c) external onlyOwner {
        c = _c;
    }

    // End of the owner part

    // Here starts part for modification. Remember that function signatures cannot be modified.

    // to optimize 1
    // Now consumes 27835
    // Should consume not more than 27830 as execution cost for non zero values
    function calc1() external view returns (uint256) {
        return b + c * a;
    }

    // to optimize 2
    // Now consumes 31253
    // Should consume not more than 30000 as execution cost for non zero values
    function calc2() external view returns (uint256) {
        uint256 a_ = a;
        uint256 b_ = b;
        uint256 c_ = c;

        return
            ((((b_ + c_) *
                (b_ + a_) +
                (c_ + a_) *
                c_ +
                c_ /
                a_ +
                c_ /
                b_ +
                2 *
                a_ -
                1 +
                a_ *
                b_ *
                c_ +
                a_ +
                b_ *
                a_) ^ 2) / (a_ + b_)) *
            c_ +
            2 *
            a_;
    }

    // to optimize 3
    // Now consumes 55446
    // Should consume not more than 54500 as execution cost
    function claimRewards(address _user) external {
        IUserInfo.User memory user_ = userInfo.getUserInfo(_user);
        require(
            user_.unlockTime <= block.timestamp,
            "MemoryTypesPracticeInput: Unlock time has not yet come"
        );

        require(!rewardsClaimed[_user], "MemoryTypesPracticeInput: Rewards are already claimed");

        require(user_.balance >= MIN_BALANCE, "MemoryTypesPracticeInput: To less balance");

        rewardsClaimed[_user] = true;
    }

    // to optimize 4
    struct Man {
        uint256 edge;
        bytes32 idOfSecretBluetoothVacinationChip;
        uint8 dickSize;
        uint32 iq;
    }

    Man[] men;

    // Now consumes 115724
    // Should consume not more than 94000 as execution cost
    function addNewMan(
        uint256 _edge,
        uint8 _dickSize,
        bytes32 _idOfSecretBluetoothVacinationChip,
        uint32 _iq
    ) public {
        men.push(Man(_edge, _idOfSecretBluetoothVacinationChip, _dickSize, _iq));
    }

    // to optimize 5
    // Now consumes 36689
    // Should consume not more than 36100 as execution cost for 6 elements array
    function getMiddleDickSize() external view returns (uint256) {
        uint256 _sum;
        uint256 _menLength = men.length;

        for (uint256 i = 0; i < _menLength; i++) {
            _sum += men[i].dickSize;
        }

        return _sum / _menLength;
    }

    // to optimize 6
    // Now consumes 68675
    // Should consume not more than 40000 as execution cost for 6 elements array
    function numberOfOldMenWithHighIq() external view returns (uint256) {
        uint256 _count;

        for (uint256 i = 0; i < men.length; i++) {
            Man memory man = men[i];
            if (man.edge > 50 && man.iq > 120) _count++;
        }

        return _count;
    }
}

// Cannot be modified
interface IUserInfo {
    struct User {
        uint256 balance;
        uint256 unlockTime;
    }

    function addUser(address _user, uint256 _balance, uint256 _unlockTime) external;

    function getUserInfo(address _user) external view returns (User memory);
}

// Cannot be modified.
contract UserInfo is IUserInfo, Ownable {
    mapping(address => User) users;

    constructor(address _validator) {
        transferOwnership(_validator);
    }

    function addUser(address _user, uint256 _balance, uint256 _unlockTime) external onlyOwner {
        users[_user] = User(_balance, _unlockTime);
    }

    function getUserInfo(address _user) external view returns (User memory) {
        return users[_user];
    }
}
