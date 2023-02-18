const PeliCoin = artifacts.require("PeliCoin");

contract("PeliCoin", (accounts) => {

  before(async () => {
    peliCoinInstance = await PeliCoin.deployed();
  });


  it("Should have the correct owner", async function () {
    const owner = await peliCoinInstance.owner();
    assert.equal(owner, accounts[0], "Owner is not accounts[0]");
  });


  it("Owner should be able mint tokens", async function () {

    await peliCoinInstance.mint(accounts[0], 200);
    const owner_balance = await peliCoinInstance.balanceOf(accounts[0]);
    assert.equal(owner_balance.toNumber(), 200, "Tokens not minted");
  });


  it("Should transfer tokens from owner to accounts", async function () {
   
    // Transfer 50 tokens from owner to account 1
    await peliCoinInstance.transfer(accounts[1], 50);
    const account_1_balance = await peliCoinInstance.balanceOf(accounts[1]);
    assert.equal(account_1_balance.toNumber(), 50);
  });


  it("Should update owner balance after transactions", async function () {
    const owner_balance = await peliCoinInstance.balanceOf(accounts[0]);
    assert.equal(owner_balance.toNumber(), 150);
  });


  it("Should transfer tokens between accounts", async function () {
   
    // Approve account 2 to spend 50 tokens from account 1
    await peliCoinInstance.approve(accounts[2], 50, {from: accounts[1]});

    // Transfer 25 tokens from account 1 to account 2
    await peliCoinInstance.transferFrom(accounts[1], accounts[2], 25, {from: accounts[2]});

    const account_1_balance = await peliCoinInstance.balanceOf(accounts[1]);
    const account_2_balance = await peliCoinInstance.balanceOf(accounts[2]);

    assert.equal(account_1_balance.toNumber(), 25);
    assert.equal(account_2_balance.toNumber(), 25);
  });
});