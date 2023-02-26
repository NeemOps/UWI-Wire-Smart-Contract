var Transactions = artifacts.require("Transactions");

module.exports = function(deployer) {
  deployer.deploy(Transactions, "0x79D3A96646f2ee21bA07AA9fC969c7853599ebD9");
};
