pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "../tokens/MintableERC20.sol";
import "../../flashloan/base/FlashLoanReceiverBase.sol";
import "../../configuration/LendingPoolAddressesProvider.sol";
import "../../configuration/NetworkMetadataProvider.sol";

contract FlashLoanReceiverExample is FlashLoanReceiverBase {

    using SafeMath for uint256;


    constructor(LendingPoolAddressesProvider _provider) FlashLoanReceiverBase(_provider)
        public {}


    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee) external returns(uint256 returnedAmount) {

        //check the contract has the specified balance
        require(_amount <= getBalanceInternal(address(this), _reserve), 
            "Invalid balance for the contract");

        /**

        CUSTOM ACTION TO PERFORM WITH THE BORROWED LIQUIDITY

        */

        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
        return _amount.add(_fee);
    }
}
