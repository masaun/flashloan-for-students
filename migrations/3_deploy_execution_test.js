const ExecutionTest = artifacts.require("./ExecutionTest.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(
    ExecutionTest
  );
};
