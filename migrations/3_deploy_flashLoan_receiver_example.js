const FlashLoanReceiverExample = artifacts.require("./FlashLoanReceiverExample.sol");
const LendingPoolAddressesProvider = artifacts.require("./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol");

// Contract address of LendingPoolAddressesProvider.sol at Kovan
let provider = LendingPoolAddressesProvider.address;
//let provider = "0xf3A9E7CF13fDf3B52846769eC40D630459050a5f"

module.exports = function(deployer, network, accounts) {
  deployer.deploy(
    FlashLoanReceiverExample,
    provider
  );
};