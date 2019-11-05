pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./FlashLoanReceiverExample.sol";

import "./storage/PhStorage.sol";
import "./modifiers/PhOwnable.sol";

contract ExecutionTest is PhStorage, PhOwnable {

    using SafeMath for uint256;

    bool private constant CONFIRMED = true;

    function executeFlashLoan(address _reserve,
                              uint256 _amount,
                              uint256 _fee) public returns (bool) {
        
        //executeOperation(_reserve, _amount, _fee);

        return CONFIRMED;
    }
    

}
