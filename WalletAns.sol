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
    uint limit;
    address [] public owners;

    constructor(address[] memory _owners, uint _limit){
        owners=_owners;
        limit=_limit;
    }

    mapping (address=>uint) balance;

    function deposit ()public payable{
        balance[msg.sender]+= msg.value;
    }
    function getBalance()view public returns(uint){
        return balance[msg.sender];
    }

    struct Transfer{
        uint  amount;
        address payable reciever;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }

    Transfer [] transferRequests;


    mapping (address=>mapping(uint=>bool)) approved;

    modifier onlyOwners(){
        bool owner = false;
    for(uint i=0; i<owners.length; i++){    
        if(owners[i] == msg.sender){
            owner =true;
        }
    require(owner == true);
    _;
        }
    }  
    
    //Do I use payable here?
    function createTransaction(uint _amount, address payable _reciever) public  onlyOwners{
        transferRequests.push(Transfer(_amount, _reciever, 0, false, transferRequests.length));
    }
    
    //Each owner can only use approve fxn once.
   function approve(uint _id) public  onlyOwners {
        // How to know somethings still needs approval?
        //approval count in struct
        //approved mapping = false
        require(approved[msg.sender][_id]== false);
        require(transferRequests[_id].hasBeenSent==false);

        transferRequests[_id].approvals++;//physically changed the approval number but how to record this to specific address?Mapping.
        approved[msg.sender][_id]=true; // address tied to tid to save mapping which txn was approved.

        if(transferRequests[_id].approvals>=limit){
            
            transferRequests[_id].reciever.transfer(transferRequests[_id].amount);
            transferRequests[_id].hasBeenSent=true;
        }
     
    }


    function getTransferRequests() public view returns(Transfer [] memory){
        return  transferRequests;
    }
}