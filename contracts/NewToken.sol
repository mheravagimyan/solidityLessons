// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NewToken {
    string private name;
    string private symbol;
    uint256 private totalSupply;
    uint8 private decimals = 18;
    uint256 public tokenPrice  = 4;



    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowances;
    mapping (address => bool) private whiteList;


    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approve(address owner, address spender, uint256 amount);
    event Buy(address buyer, uint256 amount);
    event Sell(address seller, uint256 amount);

    constructor() {
        name = "Dram";
        symbol = "AMD";
        totalSupply = 100000;
        balances[msg.sender] = totalSupply;
    }

    modifier onlyWhiteList {
        require(whiteList[msg.sender]);
        _;
    }

    function addToWhiteList(address _to) public{
        require(!whiteList[_to],"");
        whiteList[_to] = true;
    }
    
    function removeToWhiteList(address _to) public{
        require(!whiteList[_to]);
        whiteList[_to] = false;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function getSymbol() public view returns (string memory) {
        return symbol;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getDecimals() public view returns (uint8) {
        return decimals;
    }


    function balanceOf(address owner) public view onlyWhiteList returns (uint256) {
        return balances[owner];
    }

    function transfer(address to, uint256 amount) public onlyWhiteList returns (bool) {
        require(balances[msg.sender] >= amount, "NewToken: not enough funds");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from , address to, uint256 amount) public onlyWhiteList returns (bool){
        require(allowances[from][to] >= amount, "NewToken: There is no approve");
        require(balances[from] >= amount, "NewToken: not enough funds");
        allowances[from][to] -= amount;
        balances[from] -= amount;
        balances[to] += amount;
        return true;
    }

    function approve(address spender, uint256 amount) public onlyWhiteList returns (bool) {
        require(balances[msg.sender] >= amount, "NewToken: not enough funds");
        allowances[msg.sender][spender] += amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function mint(address _to, uint256 amount) public onlyWhiteList {
        totalSupply += amount;
        balances[_to] += amount;
    }
    
    function burn(uint256 amount) public onlyWhiteList{
        require(balances[msg.sender] < amount,"NewToken: can't burn");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
    }

    function buy() public payable{

        // require(msg.value == _amount * tokenPrice, "not enough funds");
        // transfer(msg.sender, _amount);
        mint(msg.sender, msg.value);

    }

    function sell(uint256 _amount) public{
        burn(_amount);
    }


}