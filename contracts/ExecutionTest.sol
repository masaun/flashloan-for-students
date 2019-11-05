pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./FlashLoanReceiverExample.sol";
import "./aave-protocol/contracts/tokenization/AToken.sol";

import "./storage/PhStorage.sol";
import "./modifiers/PhOwnable.sol";

contract ExecutionTest is PhStorage, PhOwnable {

    using SafeMath for uint256;

    bool private constant CONFIRMED = true;

    address private _aTokenAddr;

    constructor(address aToken) public {
        _aTokenAddr = aToken;
    }

    function executeFlashLoan(address _reserve,
                              uint256 _amount,
                              uint256 _fee) public returns (bool) {
        
        //executeOperation(_reserve, _amount, _fee);

        return CONFIRMED;
    }


    function redeemWithAtoken() public returns (bool) {
        /// Instantiation of the AToken address
        AToken aTokenInstance = AToken(_aTokenAddr);
        //AToken aTokenInstance = AToken("/*aToken_address*/");

        /// Input variables
        uint256 amount = 1000 * 1e18;

        /// redeem method call
        aTokenInstance.redeem(amount);

        return CONFIRMED;
    }
    
    

}
