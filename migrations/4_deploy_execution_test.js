const ExecutionTest = artifacts.require("./ExecutionTest.sol");
const _provider = '0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408'  // Contract address of LendingPoolAddressesProvider.sol which is already deployed on Kovan testnet.

let daiAddress = "0xc4375b7de8af5a38a93548eb8453a498222c4ff2"   // Contract address of DAI at Kovan


module.exports = async (deployer) => {
  await deployer.deploy(
    ExecutionTest,
    _provider,
    daiAddress
  );
};
