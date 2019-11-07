const ExecutionTest = artifacts.require("./ExecutionTest.sol");
const _provider = '0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408'  // Contract address of LendingPoolAddressesProvider.sol which is already deployed on Kovan testnet.

let daiAddress = "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD"   // Contract address of DAI at Kovan


module.exports = async (deployer) => {
  await deployer.deploy(
    ExecutionTest,
    _provider,
    daiAddress
  );
};
