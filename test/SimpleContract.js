const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  
  describe("SimpleContract", function () {
    async function deploySimpleContract() {
      const [owner, otherAccount] = await ethers.getSigners();
  
      const SimpleContract = await ethers.getContractFactory("SimpleContract");
      const simpleContract = await SimpleContract.deploy();
  
      return { simpleContract, owner, otherAccount };
    }
  
    describe("Deposit", function () {
      it("Should deposit with correct args: ", async function() {
          const { simpleContract, owner } = await loadFixture(deploySimpleContract);
      
          await simpleContract.deposit({value: 1000});
  
          expect(await simpleContract.balances(owner.address)).to.equal(1000);
  
      });
      describe("Withdraw", function() {
        it("aaa")
      });
    });
  
  });