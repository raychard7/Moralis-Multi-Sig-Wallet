// SPDX-License-Identifier: MIT
//Multi-Sig-Wallet
//(Done)Anyone can deposit into smart contract(wallet). We need a mapping to track accnt balances.
// Contract creator should be able to input //1: address of Owner,// 2. number of approvals req for transfer in "constructor". Ex set input to 3 addresses, set approval limit to 3.
// Anyone of Owners(1-3) should be able to create a transfer request.
//- Creator of Trnsf req will specify what amnt to what addy the txfer will be made.
//Owners(1-3) Should be able to approve Txfer request.
//When a Txfer request has the required approvals, txfer should be sent.
pragma solidity 0.7.5;

contract Wallet{

    address = owner;
    address rich = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address ben = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;

    int[3] owners =[owner, rich, john];

    constructor(address _owner, uint _approvals,){
        owner = msg.sender
        
    }

    mapping(address => uint) balance;//Tie balances to addresses

    //deposit just makes a number its not really ether.
    function deposit( ) public payable returns(uint){
        balance[msg.sender]+= msg.value; //removing the input param uint _toAdd, we enter msg.value instead for deposit ether.
        return balance[msg.sender];//deposit fxn returns uint
    }

    //Use array that holds all 3 addresses?
    function transfer(address recipient, uint amount) public {
        //require(array= 2)
    }

    //with mappings allows us to track a balance. How does ether tie in?
    function getBalance() public view returns(uint){
      return  balance[msg.sender]; //msg.sender will always be my own address.
    }


}

