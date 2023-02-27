var PeliWalletFacade = artifacts.require("PeliWalletFacade");

module.exports = function(deployer) {
  deployer.deploy(PeliWalletFacade, "0x79D3A96646f2ee21bA07AA9fC969c7853599ebD9");
};
