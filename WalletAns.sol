// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma abicoder v2;
//Why is variable "payable" struct Transfer => address payable reciever. => also the input _receiver for fxn deposit() is considered "payable" too.
//Test empty payable function for deposit without code. Does it work? Why? 1:55
//Create transfer  function has an "onlyOwners" modifier.

//ln47 in modifier why do we need the require at end of loop why can't it be at beginning.

//filip notes for approval.
//Set your approval for one of the txfer requests.
//Need to update the mappingto record the approval for the msg.sender.
//An owner should not be  able to vote twice.
//An owner should not be able to vote on a txfer request that has already been sent.



contract Wallet{
    // uint limit;
    address [] public owners;

    constructor(address[] memory _owners, uint limit){
        owners=_owners;
        limit=_limit;
    }

    mapping(address=>uint) balance;

    function deposit ()public payable returns(uint){
        balance[msg.sender]+= msg.value;
    }


    struct Transfer{
        uint amount;
        address sendTo;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }

    Transfer [] transferRequests;

    mapping(address=>(mapping(uint=>bool))) approved

    modifier onlyOwners(){
    //must verify owners send in request with msg.sender of addTransaction.
    bool owner =false// assumes owner is false.
    for(uint i=0;i<owners.length; i++){
        if (owners[i]== msg.sender){  //change approval number
           owner =true;
        }
        require(owner==true);
    }        
        
    }

    function addTransaction(uint _amount, address sentTo ) public onlyOwners {
        transferRequests.push(Transfer(_amount, _sendTo, 0, false, transferRequests.length)); 
    }
}