var PeliWalletFacade = artifacts.require("PeliWalletFacade");

module.exports = function(deployer) {
  deployer.deploy(PeliWalletFacade, "0x947BA28b072A2fD9f35aF931eeB21c105b98C39c");
};
