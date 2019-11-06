pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./FlashLoanReceiverExample.sol";
import "./aave-protocol/contracts/tokenization/AToken.sol";

import "./storage/PhStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/PhOwnable.sol";

contract ExecutionTest is PhStorage, AvConstants, PhOwnable {

    using SafeMath for uint256;

    function depositDAI() public returns (bool) {        
        /**
        * Deposit of 1000 DAI
        */

        /// Retrieve LendingPool address
        //address _provider = "0xeE0e5fbA06daa049A4aDF34F87cDC2C43577d7c5";
        LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(0xeE0e5fbA06daa049A4aDF34F87cDC2C43577d7c5);
        LendingPool lendingPool = LendingPool(provider.getLendingPool());

        /// Input variables

        //address daiAddress = "0xC4375B7De8af5a38a93548eb8453a498222C4fF2";
        uint256 amount = 1000 * 1e18;
        /// 0 is stable rate, 1 is variable rate
        uint256 variableRate = 1;
        uint16 referral = 0;

        /// Borrow method call
        lendingPool.borrow(0xC4375B7De8af5a38a93548eb8453a498222C4fF2, amount, variableRate, referral);

        return AvConstants.CONFIRMED;
    }


    function redeemWithAtoken(address _aTokenAddr) public returns (bool) {
        /// Instantiation of the AToken address
        AToken aTokenInstance = AToken(_aTokenAddr);
        //AToken aTokenInstance = AToken("/*aToken_address*/");

        /// Input variables
        uint256 amount = 1000 * 1e18;

        /// redeem method call
        aTokenInstance.redeem(amount);

        return AvConstants.CONFIRMED;
    }
    
}

