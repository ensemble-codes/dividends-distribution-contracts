import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SECURITY_TOKEN = "0x19cA72541e0187B1324ED75256A95BbCCf2F9C34";
const REWARDS_TOKEN = "0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238";
const OWNERS = "0x515e4af972D84920a9e774881003b2bD797c4d4b";

const RewardVaultModule = buildModule("RewardVaultModule", (m) => {
  const securityToken = m.getParameter("securityToken", SECURITY_TOKEN);
  const rewardsToken = m.getParameter("rewardsToken", REWARDS_TOKEN);
  const owner = m.getParameter("owner", OWNERS);

  const rewardVault = m.contract("RewardsVault", [securityToken, rewardsToken, owner]);

  return { rewardVault };
});

export default RewardVaultModule;
