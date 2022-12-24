const { accounts, wei } = require("../scripts/utils/utils");

const { artifacts } = require("hardhat");

const Practice2 = artifacts.require("Practice2");
const { assert } = require("chai");

const compare = (user, result) => {
  const keys = Object.keys(user);

  for (const key of keys) {
    assert.equal(user[key], result[key]);
  }
};

describe("Practice2", () => {
  let contract;

  beforeEach("setup contract", async () => {
    contract = await Practice2.new();
  });

  describe("setNewUser", () => {
    before(async () => {
      contract = await Practice2.new();
    });

    it("should add user without errors", async () => {
      const userAddress = await accounts(0);

      await contract.setNewUser(userAddress, {
        name: "Kyrylo",
        balance: 100_000_000,
        isActive: true,
      });
    });
  });

  describe("getUser", () => {
    let FIRST_ADDR;
    let FIRST = {
      name: "Kyrylo",
      balance: 100_000_000,
      isActive: true,
    };
    let SECOND_ADDR;
    let SECOND = {
      name: "Andriy",
      balance: wei("1000"),
      isActive: false,
    };

    beforeEach("setup contract storage", async () => {
      FIRST_ADDR = await accounts(0);
      SECOND_ADDR = await accounts(1);

      await contract.setNewUser(FIRST_ADDR, FIRST);
      await contract.setNewUser(SECOND_ADDR, SECOND);
    });

    it("should get first user", async () => {
      const user = await contract.getUser(FIRST_ADDR);

      compare(FIRST, user);
    });

    it("should get second user", async () => {
      const user = await contract.getUser(SECOND_ADDR);

      compare(SECOND, user);
    });
  });

  describe("getMyInfo", () => {
    let SENDER_ADDR;
    let SENDER = {
      name: "Kyrylo",
      balance: wei("100"),
      isActive: true,
    };

    beforeEach("setup contract storage", async () => {
      SENDER_ADDR = await accounts(0);

      await contract.setNewUser(SENDER_ADDR, SENDER);
    });

    it("should return user of a sender addr", async () => {
      const user = await contract.getMyInfo({
        from: SENDER_ADDR,
      });

      compare(SENDER, user);
    });
  });
});
