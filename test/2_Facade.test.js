const PeliWalletFacade = artifacts.require("PeliWalletFacade");
const PeliCoin = artifacts.require("PeliCoin");

contract("PeliWalletFacade", (accounts) => {

  let peliCoin;
  let facade_1;
  let facade_2;

  before(async () => {
    peliCoin = await PeliCoin.deployed();
  
    facade_1 = await PeliWalletFacade.new(peliCoin.address);
    facade_2 = await PeliWalletFacade.new(peliCoin.address);

    await peliCoin.mint(facade_1.address, 1000);
  });


  it("should have an initial balance of 1000 tokens", async () => {
    const balance = await facade_1.getBalance();
    assert.equal(balance.toNumber(), 1000, "Facade Test: Incorrect Balance");
  });


  it("should transfer tokens from the contract to another address", async () => {

    await facade_1.transferTokens(facade_2.address, 500);

    const account_1_balance = await facade_1.getBalance();
    assert.equal(account_1_balance.toNumber(), 500);

    const account_2_balance = await facade_2.getBalance();
    facade_2.addTransaction(facade_1.address, facade_2.address, 500);
    assert.equal(account_2_balance.toNumber(), 500);
  });


  it("Transaction history should be correct length", async () =>{
    
    await facade_1.transferTokens(accounts[2], 50);
    
    const length_1 = await facade_1.getTransactionsLength();
    assert.equal(length_1, 2, "Facade Test: Incorrect transaction length");

    const length_2 = await facade_2.getTransactionsLength();
    assert.equal(length_2, 1, "Facade Test: Incorrect transaction length");
  });


  it("Should have correct transaction history", async () =>{
    
    let transactionHistory = await facade_1.getTransactionHistory();
    console.log(transactionHistory);

    let transaction_1 = await facade_1.getTransaction(0);
    assert.equal(transaction_1.from, facade_1.address);
    assert.equal(transaction_1.to, facade_2.address);
    assert.equal(transaction_1.amount, 500);

    let transaction_2 = await facade_1.getTransaction(1);
    assert.equal(transaction_2.from, facade_1.address);
    assert.equal(transaction_2.to, accounts[2]);
    assert.equal(transaction_2.amount, 50);
  });

});