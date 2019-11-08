const FlashLoanReceiverExample = artifacts.require("./FlashLoanReceiverExample.sol");

// Contract address of LendingPoolAddressesProvider.sol at Kovan
let provider = "0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408"

module.exports = function(deployer) {
  deployer.deploy(
    FlashLoanReceiverExample,
    provider
  );
};
