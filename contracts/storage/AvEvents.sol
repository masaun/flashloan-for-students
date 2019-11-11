pragma solidity ^0.5.0;


contract AvEvents {

    // CreateLoan.sol
    event DepositedToAave(uint256 amount, address relayer);
    event WithdrawnFromAave(uint256 amount, address relayer);
    event Exited(uint256 amount);

    // CreateLoanExecutor.sol
    event CreateLoanCreated(uint256 index, address addr);
    event CreateLoanDeposited(uint256 index, address relayer);
    event CreateLoanWithdrawn(uint256 index, address relayer);
    event CreateLoanExited(uint256 index);

    // FlashLoanReceiverExample.sol
    event StudentBorrow(
        uint256 totalBorrowAmount
    );

    event ExampleEvent (
        uint exampleId,
        string exampleName,
        address exampleAddr
    );

}
