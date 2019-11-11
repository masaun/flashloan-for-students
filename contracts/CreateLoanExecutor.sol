pragma solidity ^0.5.0;

import "./CreateLoan.sol";
import "./Msg.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./storage/AvStorage.sol";
import "./storage/AvConstants.sol";
import "./modifiers/AvOwnable.sol";


contract CreateLoanExecutor is Msg, AvStorage, AvConstants, AvOwnable {
    using SafeMath for uint256;

    address public lendingPoolAddr;

    mapping(uint256 => CreateLoan) public loans;  // Notice: This is from CreateLoan.sol
    uint256 public numLoans; 


    constructor() public {
        // Kovan deployment of the lending pool.
        lendingPoolAddr = 0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408;  // Contract address of LendingPoolAddressesProvider.sol which is already deployed on Kovan testnet.
    }

    /// create a loan.
    function create(
        address tokenAddr, 
        address aTokenAddr,
        address beneficiary,
        uint256 riskTolerance, // in Ray units, whatever those are.
        uint256 reward         // in token units.
    ) external {
        CreateLoan loan = new CreateLoan(
            lendingPoolAddr,
            tokenAddr, 
            aTokenAddr,
            beneficiary,
            riskTolerance,
            reward
        );
        loans[numLoans] = loan;
        numLoans++;
        emit CreateLoanCreated(numLoans - 1, address(loan));
    }


    function exit(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        require(loan.beneficiary() == _msgSender());
        loan.exit();
        emit CreateLoanExited(index);
    }


    /// funds into Aave from the CreateLoan contract. 
    function fundDeposit(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        loan.depositToAave(_msgSender());
        emit CreateLoanDeposited(index, _msgSender());
    }


    /// funds out of Aave and back into the CreateLoan contract.
    function fundWithdrawal(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        loan.withdrawFromAave(_msgSender());
        emit CreateLoanWithdrawn(index, _msgSender());
    }
}
