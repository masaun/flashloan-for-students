const ExecutionTest = artifacts.require("./ExecutionTest.sol");

let provider = "0xe288485a9ac5346e63df116561746f2d93a0cd04"

module.exports = function(deployer, network, accounts) {
  deployer.deploy(
    ExecutionTest,
    provider
  );
};
