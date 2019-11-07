const ExecutionTest = artifacts.require("./ExecutionTest.sol");
const AToken = artifacts.require("./aave-protocol/contracts/tokenization/AToken.sol");
const LendingPoolAddressesProvider = artifacts.require("./aave-protocol/contracts/configuration/LendingPoolAddressesProvider.sol");

let daiAddress = "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359"


module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(
    ExecutionTest,
    AToken.address,  // ContractAddress of AToken.sol
    LendingPoolAddressesProvider.address,
    daiAddress
  );
};
