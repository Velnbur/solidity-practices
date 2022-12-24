const { accounts, wei } = require("../scripts/utils/utils");
const { artifacts } = require("hardhat");
const { assert } = require("chai");
const Reverter = require("./helpers/reverter");

const Practice2 = artifacts.require("Practice2");

const compare = (user, result) => {
  const keys = Object.keys(user);

  for (const key of keys) {
    assert.equal(user[key], result[key]);
  }
};

describe("Practice2", () => {
  let contract;

  let OWNER;
  let FIRST_ADDR;
  let SECOND_ADDR;

  let FIRST = {
    name: "Kyrylo",
    balance: wei("10"),
    isActive: true,
  };

  let SECOND = {
    name: "Andriy",
    balance: wei("1000"),
    isActive: false,
  };

  const reverter = new Reverter();

  before(async () => {
    OWNER = await accounts(0);

    contract = await Practice2.new({
      from: OWNER,
    });

    FIRST_ADDR = await accounts(1);
    SECOND_ADDR = await accounts(2);

    await contract.setNewUser(FIRST_ADDR, FIRST);
    await contract.setNewUser(SECOND_ADDR, SECOND);

    await reverter.snapshot();
  });

  afterEach("revert", async () => {
    await reverter.revert();
  });

  describe("getUser", () => {
    it("should get users by address", async () => {
      const firstUser = await contract.getUser(FIRST_ADDR);
      compare(FIRST, firstUser);

      const secondUser = await contract.getUser(SECOND_ADDR);
      compare(SECOND, secondUser);
    });
  });

  describe("getMyInfo", () => {
    it("should return user of a sender address", async () => {
      const user = await contract.getMyInfo({
        from: FIRST_ADDR,
      });

      compare(FIRST, user);
    });
  });

  describe("ownable", () => {
    it("should return address of creator", async () => {
      const owner = await contract.owner();

      assert.equal(owner, OWNER);
    });
  });
});
