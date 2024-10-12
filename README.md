
# Dividend Distribution Smart Contracts

## About

The repository contains dividend distribution smart contracts that are used to automate the distribution of dividends to shareholders. Automation is performed by the Ensemble protocol.

## Description

The contract has two main functions:

1. addReward - adds a new reward to the contract
2. approveReward - recieves a snapshot of the reward token distribution and distributes the reward to shareholders. This can be done by many owners in a multisig manner. The purpose of this is to allow to run the function in a decentralized manner by many workflow operators.

## Setup

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
```
