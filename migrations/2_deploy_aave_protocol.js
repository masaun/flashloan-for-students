const MintableERC20 = artifacts.require("./aave-protocol/contracts/mocks/tokens/MintableERC20.sol");
const LendingPoolAddressesProvider = artifacts.require("./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol");
//const FlashLoanReceiverBase = artifacts.require("./aave-protocol/contracts/flashloan/base/FlashLoanReceiverBase.sol");
const NetworkMetadataProvider = artifacts.require("./aave-protocol/contracts/configuration/NetworkMetadataProvider.sol");


module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(MintableERC20);
  await deployer.deploy(LendingPoolAddressesProvider);
  //await deployer.deploy(FlashLoanReceiverBase, LendingPoolAddressesProvider.address);
  await deployer.deploy(NetworkMetadataProvider);
};
