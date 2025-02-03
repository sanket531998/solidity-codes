Sanket coin code

https://gist.github.com/hkirat/7ded3b20325c32372b014e2a0013b72b// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SanketCoin {
    string public name = "Sanket";
    uint public supply;
    string public symbol = "SAN";
    address public owner;
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowances;




    constructor(){
        owner = msg.sender;
    }


    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }


    function mint (uint _amount) public onlyOwner {
        supply += _amount;
        balances[msg.sender] += _amount;


    }


    function mintTo(address _to, uint _amount) public onlyOwner {
        supply += _amount;
        balances[_to] = _amount;
    }


    function transfer (address _to, uint _amount) public returns (bool) {
        uint balance = balances[msg.sender];
        require(balance > _amount, "Insufficient balance");
        balances[_to] += _amount;
        balances[msg.sender] -= _amount;
        return true;
    }


    function burn(uint _amount) public onlyOwner {
        uint balance = balances[msg.sender];
        require(balance > _amount, "Insufficient balance");
        supply -= _amount;
        balances[msg.sender] -= _amount;
    }


    function approve (address _toWhom, uint _amount) public {
        // require(balances[msg.sender] > _amount, "Insufficient balance");
        allowances[msg.sender][_toWhom] += _amount;


    }


    function transferFrom (address _from, address _to, uint _amount) public{
        require(balances[_from] >= _amount, "Insufficient balance");
        require(allowances[_from][msg.sender] > _amount, "You dont have permisson to send this much amount");
        allowances[_from][msg.sender] -= _amount;
        balances[_from] -= _amount;
        balances[_to] -= _amount;
    }
}

