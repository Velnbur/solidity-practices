const UserInfo = artifacts.require("UserInfo");
const MemoryTypesPracticeInput = artifacts.require("MemoryTypesPracticeInput");

const VALIDATOR_ADDR = "0xBBa4D2ddE5Cc9265A85d61878331d8dC0Fa83cB5";

module.exports = async (deployer, logger) => {
  const userInfo = await deployer.deploy(UserInfo, VALIDATOR_ADDR);

  const practice3 = await deployer.deploy(MemoryTypesPracticeInput, VALIDATOR_ADDR, userInfo.address);

  // Log the contracts in an assembled table
  logger.logContracts(["MemoryTypesPracticeInput", practice3.address], ["UserInfo", userInfo.address]);
};
