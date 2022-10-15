// SPDX-License-Identifier: MIT

//Multi-Sig-Wallet
//(Done)Anyone can deposit into smart contract(wallet). We need a mapping to track accnt balances.
// Contract creator should be able to input //1: address of Owner,// 2. number of approvals req for transfer in "constructor". Ex set input to 3 addresses, set approval limit to 3.
// Anyone of Owners(1-3) should be able to create a transfer request.
//- Creator of Trnsf req will specify what amnt to what addy the txfer will be made.
//Owners(1-3) Should be able to approve Txfer request.
//When a Txfer request has the required approvals, txfer should be sent.

pragma solidity 0.7.5;
pragma abicoder v2;

contract Wallet{

    //ln22 is replaced, not a fixed array? No need to predefine other two owners?
    address[] public owners; //since public will be able to be.
    uint limit

    // address rich = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    // address ben = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    //Create array of owners first. Then in constructor define its properties. I can make public outside constructon not inside.
    // address[3] public owners; //After contract deployed this value will have the value set in constructor ln 24.
    

    // constructor() public{
        
    //     owners = [msg.sender, rich, ben]; //Can I have a preset array? [3] vs [ ].
    //     uint limit = 2; //Max number of signatures
    // }

    // inputs array of inputed owners, can have as many as I want(dynamic array)
    // limit can be inputed and keeps code dynamic instead of preset like before
    constructor(address[] memory _owners, uint _limit){
        owners = _owners;
        limit= _limit;
    }

    //Should initialize the owners list and the limit.
    modifier onlyOwners(){
        bool owner = false; // assumes owner is false. Then runs through owners and if it equals the msg.sender in list. Then owner = true.
        for(uint i=0; i<owners.length; i++){
             if(msg.sender == owners[i]){
                  owner = true;
             }
        }
       require(owner == true); 
       _; // we require owner= true, then you can continue execution of code with "_"
    }
    //XXX Not reccomended using a fxn that returns an array. Very expensive, can use up all gas.
    function getOwners() public view returns(address[3] memory){
       return owners;
    }

    mapping(address => uint) balance;//Tie balances to addresses

    //DoubleMapping 
    mapping(address => mapping(uint =>bool)) approvals;


//Why is deposit empty for filip. He only needs it to be payable?
    //deposit just makes a number its not really ether.
    function deposit( ) public payable returns(uint){
        balance[msg.sender]+= msg.value; //removing the input param uint _toAdd, we enter msg.value instead for deposit ether.
        return balance[msg.sender];//deposit fxn returns uint
    }

     function getBalance() public view returns(uint){
      return  balance[msg.sender]; //msg.sender will always be my own address.
    }

    //Does Approved fxn need to be payable??
    // function Approved(address _addy, uint tid, bool appr) public returns(bool){
    //     // boolean answer to mapping. transferid= tid
    //     approvals[_addy][tid] = appr;  //this sets my mapping to appr. Need tid to be index of array txfer

    //     //end of approve fxn count if txfer has enough votes to be sent.
    //     //loop through transfer requests(double loop?) look through each (for address), (for txfer id), if bool true = uint limit(2) send Txfer.
    //     //7:28 
    // }
    // function getApprovals(Transfer memory) payable public returns (){
        function Approved(uint _id) public onlyOwners{
            //owner should not be able to vote twice.
            require(approvals[msg.sender][_id] = false
            //Owner should not be able to vote on txfer request that was already sent.
            require(transferRequests[_id].hasBeenSent == false);
        }
    //transferRequests:  Transfer[] transferRequests;
         approvals[transferRequests.from][transferRequests.txid??] =  //doublemapping.
    }

    function getApprovals(address _addy, uint tid) public view returns(bool){

        return approvals[_addy][tid];
    }
   


    //Define what properties a Transfer should have no actual values.
    struct Transfer{
        uint amount;
        //address from; //Why no from? because msg.sender?
        address payable receiver; // Why payable variable? I thought only fxn was payable.
        uint approvals;
        bool hasBeenSent; // Not sure how this approval boo
        uint id; // tsx id? How does it build individually from each address.
    }

    Transfer[] transferRequests; // [{tx1}, {tx2}, {tx3}]
                            // index[  0  ,   1  ,   2  ]
   
    //Use array that holds all 3 addresses?
    // function addTransfer(address _recipient, uint _amount, bool _approval) payable public returns(address) { //no special reason for using _ for inputs. Just consistency for naming scheme.
    // LN 39 onlyOwners is USED!! Where is the modifier held? 
     function addTransfer(uint _amount, address payable _reciever) public  onlyOwners{
         require(balance[msg.sender] >= _amount, "Balance not Sufficient");
       //amount, receiver addy, # of approvals, has been sent True/False, transfer id is index arrays current length
        transferRequests.push(
            Transfer(_amount, _reciever ,0, false, transferRequests.length)
            ); 
        //Later add events when trnsfer is pushed.
     }
      
        
    

    //To get struct Test to return must enter pragma abicoder v2, ln 11;
    function getTransfer(uint _index) public view returns (Transfer memory){
      return transferRequests[_index];
    }
    
   


}

