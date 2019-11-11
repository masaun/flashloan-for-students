const CreateLoanExecutor = artifacts.require("CreateLoanExecutor");


module.exports = async (deployer) => {
  await deployer.deploy(
    CreateLoanExecutor
  );
};
