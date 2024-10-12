import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_URL || "",
      accounts: [process.env.PRIVATE_KEY as string]
    },
    baseSepolia: {
      url: process.env.BASE_SEPOLIA_URL || "",
      accounts: [process.env.PRIVATE_KEY as string]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY
  },
};

export default config;
