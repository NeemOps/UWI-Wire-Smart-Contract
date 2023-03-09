var PeliWalletFacade = artifacts.require("PeliWalletFacade");

module.exports = function(deployer) {
  deployer.deploy(PeliWalletFacade, "0x78c2802caf58F7302dDA14fc66274Fff485B6Fa2");
};
