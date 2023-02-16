var PeliWallet = artifacts.require("PeliWallet");

module.exports = function(deployer) {
  deployer.deploy(PeliWallet);
};
