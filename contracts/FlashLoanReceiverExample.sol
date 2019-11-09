pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./aave-protocol/contracts/lendingpool/LendingPool.sol";
import "./aave-protocol/contracts/lendingpool/LendingPoolCore.sol";

import "./aave-protocol/contracts/mocks/tokens/MintableERC20.sol";
import "./aave-protocol/contracts/flashloan/base/FlashLoanReceiverBase.sol";
import "./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol";
import "./aave-protocol/contracts/configuration/NetworkMetadataProvider.sol";

import "./storage/PhStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/PhOwnable.sol";


interface ILendingPool {
    function addressesProvider () external view returns ( address );
    function deposit ( address _reserve, uint256 _amount, uint16 _referralCode ) external payable;
    function redeemUnderlying ( address _reserve, address _user, uint256 _amount ) external;
    function borrow ( address _reserve, uint256 _amount, uint256 _interestRateMode, uint16 _referralCode ) external;
    function repay ( address _reserve, uint256 _amount, address _onBehalfOf ) external payable;
    function swapBorrowRateMode ( address _reserve ) external;
    function rebalanceFixedBorrowRate ( address _reserve, address _user ) external;
    function setUserUseReserveAsCollateral ( address _reserve, bool _useAsCollateral ) external;
    function liquidationCall ( address _collateral, address _reserve, address _user, uint256 _purchaseAmount, bool _receiveAToken ) external payable;
    function flashLoan ( address _receiver, address _reserve, uint256 _amount ) external;
    function getReserveConfigurationData ( address _reserve ) external view returns ( uint256 ltv, uint256 liquidationThreshold, uint256 liquidationDiscount, address interestRateStrategyAddress, bool usageAsCollateralEnabled, bool borrowingEnabled, bool fixedBorrowRateEnabled, bool isActive );
    function getReserveData ( address _reserve ) external view returns ( uint256 totalLiquidity, uint256 availableLiquidity, uint256 totalBorrowsFixed, uint256 totalBorrowsVariable, uint256 liquidityRate, uint256 variableBorrowRate, uint256 fixedBorrowRate, uint256 averageFixedBorrowRate, uint256 utilizationRate, uint256 liquidityIndex, uint256 variableBorrowIndex, address aTokenAddress, uint40 lastUpdateTimestamp );
    function getUserAccountData ( address _user ) external view returns ( uint256 totalLiquidityETH, uint256 totalCollateralETH, uint256 totalBorrowsETH, uint256 availableBorrowsETH, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor );
    function getUserReserveData ( address _reserve, address _user ) external view returns ( uint256 currentATokenBalance, uint256 currentUnderlyingBalance, uint256 currentBorrowBalance, uint256 principalBorrowBalance, uint256 borrowRateMode, uint256 borrowRate, uint256 liquidityRate, uint256 originationFee, uint256 variableBorrowIndex, uint256 lastUpdateTimestamp, bool usageAsCollateralEnabled );
    function getReserves () external view;
}



contract Factory {
    /// Hardcode more addresses here
    address daiAddress = 0x1c4a937d171752e1313D70fb16Ae2ea02f86303e;
    event lendingPoolCalled(string eventCalled);
    
    // Function to called by webjs
    function setCircuit(uint256 amount) external returns (bool didSucceed) {
        // Call flash loan, uses dai as base lending address provider
        LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408);
        ILendingPool ilendingPool = ILendingPool(provider.getLendingPool());

        // Create child contract
        FlashLoanReceiverExample loanContract = FlashLoanReceiverExample(0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408);
        address flashLoanReceiverExampleAddress = address(loanContract);

        /// flashLoan method call 
        ilendingPool.flashLoan(flashLoanReceiverExampleAddress, daiAddress, amount);
        emit lendingPoolCalled("Lending pool called");
        
        return true;
    }
}



contract FlashLoanReceiverExample is FlashLoanReceiverBase, PhStorage, AvConstants {

    using SafeMath for uint256;

    //bool private constant CONFIRMED = true;

    /// Retrieve the LendingPool address
    LendingPoolAddressesProvider provider;
    LendingPool lendingPool;
    ILendingPool ilendingPool;

    constructor(LendingPoolAddressesProvider _provider) FlashLoanReceiverBase(_provider) public {
        provider = LendingPoolAddressesProvider(_provider);
        lendingPool = LendingPool(_provider.getLendingPool());
        address payable core = provider.getLendingPoolCore();
        ILendingPool ilendingPool = ILendingPool(provider.getLendingPool());
    }


    function studentflashLoan(uint _amount) public returns (bool) {
        /// Hardcode more addresses here
        address daiAddress = 0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD;

        /// flashLoan method call 
        ilendingPool.flashLoan(address(this), daiAddress, _amount);
        //lendingPool.flashLoan(address(this), daiAddress, _amount);
        
        return true;
    }
    

    function executeOperation(address _reserve,
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

        emit StudentBorrow(_totalBorrowAmount);

        return _totalBorrowAmount;
    }


    function testFunc() public returns (bool) {
        return AvConstants.CONFIRMED;
    }
}
