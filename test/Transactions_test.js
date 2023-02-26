const Transactions = artifacts.require("Transactions");
const Pelicoin     = artifacts.require("Pelicoin"); 

contract("Transactions", (accounts) => {

    let transactions;
    let pelicoinInstance;

    before(async () => {
        pelicoinInstance = await Pelicoin.deployed();
        transactions = await Transactions.new(pelicoinInstance.address);
    });


    //SHOULD RECEIVE TOKENS
    it("Should receive tokens", async() => {

        const amount = 100;

        await pelicoinInstance.mint(accounts[0], amount);
        await pelicoinInstance.transfer(accounts[1], amount);
        await pelicoinInstance.approve(transactions.address, amount, {from: accounts[1]});

        await transactions.receiveTokens(amount, {from: accounts[1]});
        const balance = await pelicoinInstance.balanceOf(transactions.address);
        assert.equal(balance, amount, "Incorrect balance");
        
        const tx = await transactions.getTransaction(0);
        assert.equal(tx.from, accounts[1], "Incorrect sender");
        assert.equal(tx.to, transactions.address, "Incorrect recipient");
        assert.equal(tx.amount, amount, "Incorrect amount");
    });


    //SHOULD SEND TOKENS
    it("Should send tokens", async () => {
        
        const amount = 50;
        const recipient = accounts[1];

        await transactions.sendTokens(recipient, amount);
        const balance = await pelicoinInstance.balanceOf(transactions.address);
        assert.equal(balance, 50, "Incorrect balance");

        const tx = await transactions.getTransaction(1);
        assert.equal(tx.from, transactions.address, "Incorrect sender");
        assert.equal(tx.to, recipient, "Incorrect recipient");
        assert.equal(tx.amount, amount, "Incorrect amount");
    });

    
    //SHOULD WITHDRAW TOKENS
    it("Should withdraw tokens", async () => {
       
        const amount = 30;

        await transactions.withdrawTokens(amount);
        const balance = await pelicoinInstance.balanceOf(transactions.address);
        assert.equal(balance.toNumber(), 20, "Incorrect balance");
    
        const tx = await transactions.getTransaction(2);
        assert.equal(tx.from, transactions.address, "Incorrect sender");
        assert.equal(tx.to, accounts[0], "Incorrect recipient");
        assert.equal(tx.amount, amount, "Incorrect amount");
    });


    it("Should return the correct token balance", async () => {
        const balance = await transactions.balanceOf();
        assert.equal(balance, 20, "Incorrect balance");
    });


    it("Should return the correct token address", async () => {
        const address = await transactions.getTokenAddress();
        assert.equal(address, pelicoinInstance.address, "Incorrect token address");
    });


    it("Should return the correct transaction history length", async () => {
        const length = await transactions.getTransactionHistoryLength();
        assert.equal(length, 3, "Incorrect transaction history length");
    });


    it("Should return the correct transaction by index", async () => {
        const tx = await transactions.getTransaction(1);
        assert.equal(tx.from, transactions.address, "Incorrect sender");
        assert.equal(tx.to, accounts[1], "Incorrect recipient");
        assert.equal(tx.amount, 50, "Incorrect amount");
  });
});