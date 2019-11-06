const MintableERC20 = artifacts.require("./aave-protocol/contracts/mocks/tokens/MintableERC20.sol");
const LendingPoolAddressesProvider = artifacts.require("./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol");
//const FlashLoanReceiverBase = artifacts.require("./aave-protocol/contracts/flashloan/base/FlashLoanReceiverBase.sol");
const NetworkMetadataProvider = artifacts.require("./aave-protocol/contracts/configuration/NetworkMetadataProvider.sol");
const AToken = artifacts.require("./aave-protocol/contracts/tokenization/AToken.sol");


// Arguments of AToken
let _addressesProvider = LendingPoolAddressesProvider.address
let _underlyingAsset = '0x8Ac14CE57A87A07A2F13c1797EfEEE8C0F8F571A'
let _underlyingAssetDecimals = 18 
let _name = 'aDAI'
let _symbol = 'aDAI'
let _decimals = 18
let _initialExchangeRate = 1



module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(MintableERC20);
  await deployer.deploy(LendingPoolAddressesProvider);
  //await deployer.deploy(FlashLoanReceiverBase, LendingPoolAddressesProvider.address);
  await deployer.deploy(NetworkMetadataProvider);
  await deployer.deploy(AToken, _addressesProvider, _underlyingAsset, _underlyingAssetDecimals, _name, _symbol, _decimals, _initialExchangeRate);
};
