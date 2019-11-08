pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./aave-protocol/contracts/mocks/tokens/MintableERC20.sol";
import "./aave-protocol/contracts/flashloan/base/FlashLoanReceiverBase.sol";
import "./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol";
import "./aave-protocol/contracts/configuration/NetworkMetadataProvider.sol";

import "./storage/PhStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/PhOwnable.sol";

contract FlashLoanReceiverExample is FlashLoanReceiverBase, PhStorage, AvConstants {

    using SafeMath for uint256;

    //bool private constant CONFIRMED = true;

    constructor(LendingPoolAddressesProvider _provider) FlashLoanReceiverBase(_provider) public {
        // Nothing
    }


    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee) public returns (uint256 returnedAmount) {

        //check the contract has the specified balance
        require(_amount <= getBalanceInternal(address(this), _reserve), 
            "Invalid balance for the contract");

        /**

        CUSTOM ACTION TO PERFORM WITH THE BORROWED LIQUIDITY

        */

        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
        return _amount.add(_fee);
    }


    function studentBorrow(address _reserve,
                           uint256 _amount,
                           uint256 _fee) public returns (uint256 totalBorrowAmount) {

        uint _totalBorrowAmount;

        _totalBorrowAmount = executeOperation(_reserve, _amount, _fee);

        //emit StudentBorrow(_totalBorrowAmount);

        return _totalBorrowAmount;
    }
    

    function testFunc() public returns (bool) {
        return AvConstants.CONFIRMED;
    }
}
