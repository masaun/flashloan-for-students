pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./FlashLoanReceiverExample.sol";
import "./aave-protocol/contracts/tokenization/AToken.sol";

import "./storage/PhStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/PhOwnable.sol";

contract ExecutionTest is PhStorage, AvConstants, PhOwnable {

    using SafeMath for uint256;

    AToken aToken;
    constructor(AToken _aTokenAddr) public {
        // Nothing
        aToken = _aTokenAddr;
    }


    function redeemWithAtoken() public returns (bool) {
        /// Instantiation of the AToken address
        AToken aTokenInstance = AToken(aToken);
        //AToken aTokenInstance = AToken("/*aToken_address*/");

        /// Input variables
        uint256 amount = 1000 * 1e18;

        /// redeem method call
        aTokenInstance.redeem(amount);

        return AvConstants.CONFIRMED;
    }
    
}

