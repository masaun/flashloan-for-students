pragma solidity ^0.5.0;


contract PhEvents {

    event StudentBorrow(
        uint256 totalBorrowAmount
    );
    

    event AddReputation (
        uint256 tokenId,
        uint256 reputationCount
    );

    event ExampleEvent (
        uint exampleId,
        string exampleName,
        address exampleAddr
    );

}
