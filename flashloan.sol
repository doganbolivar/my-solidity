pragma solidity ^0.8.0;

//create a contract for flashloan opportunity
contract Flashloan {
    //create a struct for the loan
    struct Loan {
        address borrower;
        uint amount;
        uint interest;
        uint term;
        uint payment;
        uint balance;
        uint timestamp;
    }

    //create a mapping for the loan
    mapping(address => Loan) public loans;

    //create a function to create a loan
    function createLoan(address borrower, uint amount, uint interest, uint term) public {
        //create a new loan
        Loan loan = Loan(borrower, amount, interest, term, 0, amount, now);
        //add the loan to the mapping
        loans[borrower] = loan;
    }

    //create a function to pay a loan
    function payLoan(address borrower, uint amount) public {
        //get the loan from the mapping
        Loan loan = loans[borrower];
        //check if the loan exists
        require(loan.borrower == borrower);
        //check if the amount is less than the balance
        require(amount <= loan.balance);
        //update the loan
        loan.balance -= amount;
        loan.payment += amount;
        //add the loan to the mapping
        loans[borrower] = loan;
    }

    //create a function to get the loan
    function getLoan(address borrower) public view returns (Loan) {
        //get the loan from the mapping
        Loan loan = loans[borrower];
        //check if the loan exists
        require(loan.borrower == borrower);
        //return the loan
        return loan;
    }
}