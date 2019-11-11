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

    mapping(uint256 => CreateLoan) public loans;
    uint256 public numLoans; 

    event CreateLoanCreated(uint256 index, address addr);
    event CreateLoanDeposited(uint256 index, address relayer);
    event CreateLoanWithdrawn(uint256 index, address relayer);
    event CreateLoanExited(uint256 index);

    constructor() public {
        // Kovan deployment of the lending pool.
        lendingPoolAddr = 0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408;  // Contract address of LendingPoolAddressesProvider.sol which is already deployed on Kovan testnet.
    }

    /// Someone can call this function on behalf of a beneficiaryin order to 
    /// create a managed loan. Note they will need to transfer the tokens into
    /// the new CreateLoan contract afterwards. 
    function create(
        address tokenAddr, 
        address aTokenAddr,
        address beneficiary,
        uint256 riskTolerance, // in Ray units, whatever those are.
        uint256 reward // in token units.
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

    /// Called by the beneficiary of the loan when they want to exit the system. 
    function exit(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        require(loan.beneficiary() == _msgSender());
        loan.exit();
        emit CreateLoanExited(index);
    }

    /// Called by an economically incentivized market participant to transfer
    /// funds into Aave from the CreateLoan contract. 
    function fundDeposit(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        loan.depositToAave(_msgSender());
        emit CreateLoanDeposited(index, _msgSender());
    }

    /// Called by an economically incentivized market participant to transfer
    /// funds out of Aave and back into the CreateLoan contract.
    function fundWithdrawal(uint256 index) external {
        require(index < numLoans, "bad index");
        CreateLoan loan = loans[index];
        loan.withdrawFromAave(_msgSender());
        emit CreateLoanWithdrawn(index, _msgSender());
    }
}
