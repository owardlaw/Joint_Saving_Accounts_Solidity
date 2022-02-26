// Joint Saving Solitidy

pragma solidity ^0.5.0;

contract JointSavings {

    // Variables to be used for setting transaction information 

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount; 
    uint public contractBalance;

    /*
    Funtction to accept withdraws
    */
    function withdraw(uint amount, address payable recipient) public {

     
        // Requires account is equal to one of the two verified accounts

        require(recipient == accountOne || recipient == accountTwo, "You don't own this account");

        // Requires account has enough funds to withdraw

        require(contractBalance>=amount, "Insufficient funds!");

        // Checks if lastToWithdraw does not equal to the recipient

        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Passes withdraw amount

        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount` 

        lastWithdrawAmount=amount;

        // Reflects the balance of the contract

        contractBalance=address(this).balance;
    }

    // Public payable depotion function

    function deposit() public payable {

      
        // Setting contractBalance equal to the actual contract balance

        contractBalance = address(this).balance;
    }

    // Defines two accounts user can interact with 

    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.

        accountOne=account1;
        accountTwo=account2;
    }

    
    // Function for storing Ether from outside the deposit function

     function() external payable {}
}
