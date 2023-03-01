const PeliWalletFacade = artifacts.require("PeliWalletFacade");
const PeliCoin = artifacts.require("PeliCoin");

contract("PeliWalletFacade", (accounts) => {

  let peliCoin;
  let transactions;
  let peliWalletFacade;


  before(async () => {
    peliCoin = await PeliCoin.deployed();
    // transactions = await transactions.deployed();
    peliWalletFacade = await PeliWalletFacade.new(peliCoin.address);

    await peliCoin.mint(peliWalletFacade.address, 1000);
  });


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


  it("Transaction history should be correct length", async () =>{
    
    await peliWalletFacade.transferTokens(accounts[2], 50);
    
    const length = await peliWalletFacade.getTransactionsLength();
    assert.equal(length, 2, "Facade Test: Incorrect transaction length");
  });


  it("Should have correct transaction history", async () =>{
    
    let transactionHistory = await peliWalletFacade.getTransactionHistory();
    console.log(transactionHistory);

    let transaction_1 = await peliWalletFacade.getTransaction(0);
    assert.equal(transaction_1.from, peliWalletFacade.address);
    assert.equal(transaction_1.to, accounts[1]);
    assert.equal(transaction_1.amount, 500);

    let transaction_2 = await peliWalletFacade.getTransaction(1);
    assert.equal(transaction_2.from, peliWalletFacade.address);
    assert.equal(transaction_2.to, accounts[2]);
    assert.equal(transaction_2.amount, 50);
  });

});