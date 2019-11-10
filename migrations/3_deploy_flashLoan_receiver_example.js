const FlashLoanReceiverExample = artifacts.require("FlashLoanReceiverExample");
const Factory = artifacts.require("Factory");


// Contract address of LendingPoolAddressesProvider.sol at Kovan
let provider = "0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408"

module.exports = async (deployer) => {
  await deployer.deploy(
    FlashLoanReceiverExample,
    provider
  );
  await deployer.deploy(
    Factory
  );
};
