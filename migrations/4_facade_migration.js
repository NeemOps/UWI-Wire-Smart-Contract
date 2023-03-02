var PeliWalletFacade = artifacts.require("PeliWalletFacade");

module.exports = function(deployer) {
  deployer.deploy(PeliWalletFacade, "0x493B20eD28A3F59Ee11cf80B7cF98b7e7D92fcB1");
};
