// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardsVault {
    IERC20 public securityToken;
    IERC20 public rewardsToken;
    address[] public owners;
    uint256 public rewardCounter;

    struct Reward {
        uint256 timestamp;
        uint256 amount;
        bool distributed;
    }

    mapping(uint256 => Reward) public rewards;
    mapping(address => bool) public isOwner;

    event RewardAdded(uint256 rewardId, uint256 timestamp, uint256 amount);
    event RewardDistributed(uint256 rewardId, address[] tokenHolders, uint256[] percentages);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Caller is not an owner");
        _;
    }

    constructor(IERC20 _securityToken, IERC20 _rewardsToken, address _owner) {
        securityToken = _securityToken;
        rewardsToken = _rewardsToken;
        owners.push(_owner);
        isOwner[_owner] = true;
        rewardCounter = 0;
    }

    function addReward(uint256 timestamp, uint256 amount) external onlyOwner {
        // Assuming rewardsToken is an ERC20 token
        bool success = rewardsToken.transferFrom(msg.sender, address(this), amount);
        require(success, "Token transfer to contract failed");

        rewards[rewardCounter] = Reward(timestamp, amount, false);
        emit RewardAdded(rewardCounter, timestamp, amount);
        rewardCounter++;
    }

    function approveDistribution(address[] calldata tokenHolders, uint256[] calldata tokenAmounts, uint256 rewardId) external onlyOwner {
        require(rewards[rewardId].amount > 0, "Reward does not exist");
        require(!rewards[rewardId].distributed, "Reward already distributed");
        require(tokenHolders.length == tokenAmounts.length, "Token holders and token amounts length mismatch");

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < tokenAmounts.length; i++) {
            totalAmount += tokenAmounts[i];
        }
        require(totalAmount == rewards[rewardId].amount, "Total token amount must equal reward amount");

        for (uint256 i = 0; i < tokenHolders.length; i++) {
            uint256 rewardAmount = (rewards[rewardId].amount * tokenAmounts[i]) / totalAmount;
            // Assuming rewardsToken is an ERC20 token
            bool success = rewardsToken.transfer(tokenHolders[i], rewardAmount);
            require(success, "Token transfer failed");
        }

        rewards[rewardId].distributed = true;
        emit RewardDistributed(rewardId, tokenHolders, tokenAmounts);
    }
}
