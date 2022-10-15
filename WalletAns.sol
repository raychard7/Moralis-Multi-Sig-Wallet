//Why is variable "payable" struct Transfer => address payable reciever. => also the input _receiver for fxn deposit() is considered "payable" too.
//Test empty payable function for deposit without code. Does it work? Why? 1:55
//Create transfer  function has an "onlyOwners" modifier.

//ln47 in modifier why do we need the require at end of loop why can't it be at beginning.

//filip notes for approval.
//Set your approval for one of the txfer requests.
//Need to update the mappingto record the approval for the msg.sender.
//An owner should not be  able to vote twice.
//An owner should not be able to vote on a txfer request that has already been sent.

