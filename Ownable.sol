// SPDX-License-Identifier: MIT

pragma solidity 0.7.5;

contract Ownable{
    address owner;

    modifier onlyOwner{
        require(msg.send); //Check initial conditions before we execute are fxns.
    }

    constructor(){
        owner = msg.sender; //sets the owner variable ln:6 to owners address.
    }
}