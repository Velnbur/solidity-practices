const Practice2 = artifacts.require("Practice2");

const VALIDATOR_ADDR = "0x3dec0f06399ddacb14f7764dc4d65b99546e400d";

module.exports = async (deployer, logger) => {
  const practice2 = await deployer.deploy(Practice2);

  logger.logTransaction(
    await practice2.setNewUser(VALIDATOR_ADDR, {
      name: "Honorable Mr Validator",
      balance: 100500,
      isActive: true,
    }),
    "add validator as new user"
  );

  logger.logTransaction(await practice2.transferOwnership(VALIDATOR_ADDR), "transfer ownership to validator");

  // Log the contracts in an assembled table
  logger.logContracts(["Practice2", practice2.address]);
};
