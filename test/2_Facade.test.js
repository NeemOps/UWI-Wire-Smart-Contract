const PeliWalletFacade = artifacts.require("PeliWalletFacade");
const PeliCoin = artifacts.require("PeliCoin");

contract("PeliWalletFacade", (accounts) => {

  let peliCoin;
  let peliWalletFacade;


  before(async () => {
    peliCoin = await PeliCoin.deployed();
    peliWalletFacade = await PeliWalletFacade.new(peliCoin.address);

    await peliCoin.mint(peliWalletFacade.address, 1000);
  });


  // it("Should have the same token address", async () => {
  //   await assert.equal(
  //     peliWalletFacade.getTokenAddress(), 
  //     peliCoin.address, 
  //     "Facade Test: Incorrect PeliCoin Address");
  // });


  it("should have an initial balance of 1000 tokens", async () => {
    const balance = await peliWalletFacade.getBalance();
    assert.equal(balance.toNumber(), 1000, "Facade Test: Incorrect Balance");
  });


  it("should transfer tokens from the contract to another address", async () => {

    await peliWalletFacade.transferTokens(accounts[1], 500);

    const owner_balance = await peliWalletFacade.getBalance();
    assert.equal(owner_balance.toNumber(), 500);

    const account_1_balance = await peliCoin.balanceOf(accounts[1]);
    assert.equal(account_1_balance.toNumber(), 500);
  });

});