// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract SimpleContract{

    mapping(address => uint256) public balances;
    uint256 public totalAmount;
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() public payable{
      balances[msg.sender] += msg.value;
      totalAmount += msg.value; 
      emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public {
        uint256 transferAmount = balances[msg.sender];
        balances[msg.sender] = 0;
        totalAmount -= transferAmount;
        payable(msg.sender).transfer(transferAmount);
    }

    function withdraw(uint256 withdrawAmount) public{
        require(balances[msg.sender] >= withdrawAmount, "Not enough funds");
        balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
        emit Withdraw(msg.sender, withdrawAmount);
    }
}