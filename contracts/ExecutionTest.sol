pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./aave-protocol/contracts/lendingpool/LendingPool.sol";
import "./aave-protocol/contracts/tokenization/AToken.sol";


import "./FlashLoanReceiverExample.sol";
import "./storage/AvStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/AvOwnable.sol";

contract ExecutionTest is AvStorage, AvConstants, AvOwnable {

    using SafeMath for uint256;

    address daiAddress;

    // Define instance of external contracts
    LendingPoolAddressesProvider provider;
    LendingPool lendingPool;
    FlashLoanReceiverExample flashLoanReceiverExample;

    constructor(LendingPoolAddressesProvider _provider, address _daiAddress) public {
        provider = LendingPoolAddressesProvider(_provider);
        lendingPool = LendingPool(_provider.getLendingPool());

        daiAddress = _daiAddress;
    }


    // Successful to call and get result.
    function getActiveReserves() public view returns (address[] memory _getReserves) {
        return lendingPool.getReserves();
    }
    

    // function flashLoanOperation(address _reserve, uint256 _amount, uint256 _fee) public returns (bool) {
    //     flashLoanReceiverExample.executeOperation(_reserve, _amount, _fee);
    // }
    

    /**
    * Enable usage of the DAI reserve as collateral for the user
    */
    function reserveDaiAsCollateral(address _checksumedAddress) public returns (bool) {
        /// Input variables
        address daiAddress = _checksumedAddress;
        bool useAsCollateral = true;

        /// setUserUseReserveAsCollateral method call
        lendingPool.setUserUseReserveAsCollateral(daiAddress, useAsCollateral);
    }
    


    /**
    * Deposit of 1000 DAI
    */
    function depositDAI() public payable returns (bool) {
        lendingPool.deposit(address(uint160(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD)), 100, 0);
        //lendingPool.deposit(activeReserveAddress, amount, referral);
    }
    



    // function redeemWithAtoken() public returns (bool) {
    //     /// Instantiation of the AToken address
    //     AToken aTokenInstance = AToken(aToken);
    //     //AToken aTokenInstance = AToken("/*aToken_address*/");

    //     /// Input variables
    //     uint256 amount = 1000 * 1e18;

    //     /// redeem method call
    //     aTokenInstance.redeem(amount);

    //     return AvConstants.CONFIRMED;
    // }
    
}

