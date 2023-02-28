// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./PeliWallet.sol";
import "./Transactions.sol";


contract PeliWalletFacade is Ownable, Pausable{
   
    PeliWallet private peliWallet;
    Transactions private transactionsManager;
    IERC20 private pelicoin; 


    constructor(address pelicoinAddress){
        peliWallet = new PeliWallet();
        transactionsManager = new Transactions();
        pelicoin = IERC20(pelicoinAddress);
    }

    function transferTokens(address to, uint256 amount) external whenNotPaused onlyOwner{
        pelicoin.transfer(to, amount);
        // peliWallet.transferTokens(pelicoin, to, amount);
        transactionsManager.createTransaction(address(this), to, amount);
    }

    function withdrawTokens(IERC20 token, uint256 amount) public whenNotPaused onlyOwner{
        peliWallet.withdraw(token, amount);
    }

    function getBalance() external view returns (uint256){
        return peliWallet.balanceOf(pelicoin, address(this));
    }


    // Get Pelicoin token address
    function getTokenAddress() external view returns (address){
        return address(pelicoin);
    }
}