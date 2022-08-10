const {
    loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");
const { isCallTrace } = require("hardhat/internal/hardhat-network/stack-traces/message-trace");

describe("NewToken", function () {
    async function deployNewToken() {
        const [owner, reciever] = await ethers.getSigners();
        
        const NewToken = await ethers.getContractFactory("NewToken");
        const newToken = await NewToken.deploy();

        return { newToken, owner, reciever };
    }

    describe("Intialization", function() {
        const  totalSupply = 100000;
        it("Test for constructor: name", async function(){
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            expect(await newToken.getName()).to.equal("Dram");
        });
        
        it("Test for constructor: symbol", async function(){
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            expect(await newToken.getSymbol()).to.equal("AMD");
        });

        it("Test for constructor: totalSupply", async function(){
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            expect(await newToken.getTotalSupply()).to.equal(totalSupply);
        });

        it("Test for constructor: balance", async function(){
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            expect(await newToken.balanceOf(owner.address)).to.equal(totalSupply);
        });
    });

    describe("Transfer", function() {
        it("Test for transfer", async function () {

            const totalSupply = 100000;
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            await newToken.addToWhiteList(owner.address);
            await newToken.addToWhiteList(reciever.address);
            await newToken.transfer(reciever.address, 1000);
            expect(await newToken.balanceOf(owner.address)).to.equal(totalSupply - 1000);
            expect(await newToken.balanceOf(reciever.address)).to.equal(1000);
        
        });
    });

    // describe("TransferFrom", function() {
    //     it("Test for TransferFrom", async function() {
    //         const { newToken, owner, reciever } = await loadFixture(deployNewToken);
    //         await newToken.transferFrom(owner.address, reciever.address, 1000);
    //         expect(await newToken.balanceOf(owner.address)).to.equal(100000 - 1000);
    //         expect(await newToken.balanceOf(reciever.address)).to.equal(1000);
    //     });
    // });
    
    describe("Approve", function() {
        it("Test for Approve", async function() {
            const { newToken, owner, reciever } = await loadFixture(deployNewToken);
            const approveAmount = 10000;
            await newToken.addToWhiteList(reciever.address);

            // const totalSupply =  newToken.balanceOf(owner.address);
            await newToken.approve(reciever.address, approveAmount);
            expect(await newToken.balanceOf(reciever.address)).to.equal(approveAmount);
            // expect(await newToken.)
        });
    });

});