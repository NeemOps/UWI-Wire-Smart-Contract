// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./PeliWallet.sol";
import "./Transactions.sol";


contract PeliWalletFacade{
   
    PeliWallet private peliWallet;
    Transactions private transactionsManager;
    IERC20 private pelicoin; 


    constructor(address pelicoinAddress){
        peliWallet = new PeliWallet();
        transactionManager = new Transaction();
        pelicoin = IERC20(pelicoinAddress);
    }

    function transferTokens(address to, uint256 amount) external whenNotPaused onlyOwner{
        peliWallet.send(pelicoin, to, amount);
        transactionManager.createTransaction(address(this), to, amount);
    }

    function withdrawTokens(uint256 amount) public whenNotPaused onlyOwner{
        peliWallet.withdraw(pelicoin, amount);
    }

    function getBalance() external view returns (uint256){
        peliWallet.balanceOf(address(this));
    }

    // Get Pelicoin token address
    function getTokenAddress() external view returns (address){
        return address(pelicoin);
    }

}