const PeliCoin = artifacts.require("PeliCoin");

contract("PeliCoin", (accounts) => {

    // it("Ensures that the right owner is set", async function(){
    //     const peliCoinInstance = await PeliCoin.deployed();
    //     expect(await peliCoinInstance.owner).to.equal(PeliCoin.owner);
    // });


    it("Should transfer tokens from owner to accounts", async function () {

        const peliCoinInstance = await PeliCoin.deployed();
        
        // Transfer 50 tokens from owner to account 1
        await peliCoinInstance.transfer(accounts[1], 50);
        const account_1_balance = await peliCoinInstance.balanceOf(accounts[1]);
        assert.equal(account_1_balance, 50);
    });

    // it("Should transfer tokens between accounts", async function () {
        
    //     const peliCoinInstance = await PeliCoin.deployed();
        
    //     // // Transfer 50 tokens from owner to account 1
    //     // await peliCoinInstance.transfer(accounts[1], 100);
        
    //     // Transfer 25 tokens from account 1 to account 2
    //     await peliCoinInstance.transferFrom(accounts[1], accounts[2], 50);
    //     const account_2_balance = await peliCoinInstance.balanceOf(accounts[2]);
    //     assert.equal(account_2_balance, 50);
    // });

     


    // it("Should fail if sender doesn't have enough tokens", async function () {

    //   const peliCoinInstance = await PeliCoin.deployed();

    //   const initialOwnerBalance = await peliCoinInstance.balanceOf(owner.address);
    //   // Try to send 1 token from addr1 (0 tokens) to owner (1000000 tokens).
    //   // `require` will evaluate false and revert the transaction.
    //   await 
    //       expect( 
    //           peliCoinInstance.connect(accounts[0]).transfer(owner.address, 1)
    //       ).to.be.revertedWith("ERC20: transfer amount exceeds balance");

    //   // Owner balance shouldn't have changed.
    //   expect(await peliCoinInstance.balanceOf(owner.address)).to.equal(
    //     initialOwnerBalance
    //   );
    // });


    // /* CHECKS IF BALANCE GET UPDATED AFTER TRANSFERS */
    // it("Should update balances after transfers", async function () {

    //   const peliCoinInstance = await PeliCoin.deployed();
        
    //   const initialOwnerBalance = await peliCoinInstance.balanceOf(owner.address);

    //   // Transfer 100 tokens from owner to account 1.
    //   await peliCoinInstance.transfer(accounts[0].address, 100);

    //   // Transfer another 50 tokens from owner to account 2.
    //   await peliCoinInstance.transfer(accounts[1].address, 50);

    //   // Checking balances
    //   const finalOwnerBalance = await peliCoinInstance.balanceOf(owner.address);
    //   expect(finalOwnerBalance).to.equal(initialOwnerBalance.sub(150));

    //   const account_1_balance = await peliCoinInstance.balanceOf(accounts[0].address);
    //   expect(account_1_balance).to.equal(100);

    //   const account_2_balance = await peliCoinInstance.balanceOf(accounts[1].address);
    //   expect(account_2_balance).to.equal(50);
    // });
});