const ExecutionTest = artifacts.require("./ExecutionTest.sol");
const AToken = artifacts.require("./aave-protocol/contracts/tokenization/AToken.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(
    ExecutionTest,
    //AToken.address  // ContractAddress of AToken.sol
  );
};
