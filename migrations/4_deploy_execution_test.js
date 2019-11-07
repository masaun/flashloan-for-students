const ExecutionTest = artifacts.require("./ExecutionTest.sol");
//const AToken = artifacts.require("./aave-protocol/contracts/tokenization/AToken.sol");
const _provider = '0x9C6C63aA0cD4557d7aE6D9306C06C093A2e35408'

let daiAddress = "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359"


module.exports = async (deployer) => {
  await deployer.deploy(
    ExecutionTest,
    _provider,
    daiAddress
  );
};
