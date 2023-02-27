const DirectDeposit = artifacts.require("DirectDeposit");

module.exports = function (deployer) {
  deployer.deploy(DirectDeposit);
};
