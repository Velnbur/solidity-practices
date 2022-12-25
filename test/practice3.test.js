const { assert } = require("chai");
const { accounts } = require("../scripts/utils/utils");
const { artifacts } = require("hardhat");
const Reverter = require("./helpers/reverter");
const { setTime } = require("./helpers/block-helper");

const Practice3 = artifacts.require("MemoryTypesPracticeInput");
const UserInfo = artifacts.require("UserInfo");

describe("Practice3", () => {
  let VALIDATOR;

  let practice3;
  let userInfoContract;

  const reverter = new Reverter();

  const A = 100_000;
  const B = 123_123;
  const C = 1_000_000_000;

  before(async () => {
    VALIDATOR = await accounts(0);

    userInfoContract = await UserInfo.new(VALIDATOR);

    const currentTime = 100;
    await setTime(currentTime);

    await userInfoContract.addUser(VALIDATOR, 12_000, currentTime - 1);

    practice3 = await Practice3.new(VALIDATOR, userInfoContract.address);

    await practice3.setA(A);
    await practice3.setB(B);
    await practice3.setC(C);

    await reverter.snapshot();
  });

  afterEach("revert", async () => {
    await reverter.revert();
  });

  describe("calc1", () => {
    it.skip("should consume not more than 27830 gas", async () => {
      const tx = await practice3.calc1.sendTransaction();

      const gasUsed = tx.receipt.gasUsed;
      console.log("gas used by calc1:", gasUsed);

      assert.isBelow(gasUsed, 27830);
    });
  });

  describe("calc2", () => {
    it("should consume not more than 30000 gas", async () => {
      const tx = await practice3.calc2.sendTransaction();

      const gasUsed = tx.receipt.gasUsed;

      assert.isBelow(gasUsed, 30_000);
    });
  });

  describe("claimRewards", () => {
    it("should consume not more than 54500 gas", async () => {
      const tx = await practice3.claimRewards.sendTransaction(VALIDATOR);

      const gasUsed = tx.receipt.gasUsed;
      console.log("gas used: ", gasUsed);

      assert.isBelow(gasUsed, 54_500);
    });
  });

  describe("addNewMan", () => {
    it("should consume not more than 94000 gas", async () => {
      const tx = await practice3.addNewMan.sendTransaction(10, 255, "0x000000123213", 155);

      const gasUsed = tx.receipt.gasUsed;
      console.log("gas used: ", gasUsed);

      assert.isBelow(gasUsed, 94_000);
    });
  });
});
