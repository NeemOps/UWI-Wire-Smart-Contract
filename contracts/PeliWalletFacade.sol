// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import "./Transactions.sol";


contract PeliWalletFacade is Ownable, Pausable, ReentrancyGuard{

    using Address for address;
   
    // PeliWallet private peliWallet;
    Transactions private transactionsManager;
    IERC20 private pelicoin; 


    constructor(address pelicoinAddress){
        transactionsManager = new Transactions();
        pelicoin = IERC20(pelicoinAddress);
    }


    /* PELICOIN TOKEN */

        // Gets Token Address
        function getTokenAddress() external view returns (address){
            return address(pelicoin);
        }


    /* WALLET TRANSACTIONS */

        // Transfers pelicoin to another account
        function transferTokens(address to, uint256 amount) external whenNotPaused onlyOwner nonReentrant{
         
            require(to != address(0), "PeliWallet: recipient cannot be zero address");
            require(amount > 0,       "PeliWallet: amount must be greater than zero");
    
            require(pelicoin.transfer(to, amount), "PeliWallet: Transfer Failed");
     
            transactionsManager.createTransaction(address(this), to, amount);
        }

        // Update transaction history
        function addTransaction(address from, address to, uint256 amount) external 
        whenNotPaused onlyOwner nonReentrant{
            transactionsManager.createTransaction(from, to, amount);
        }

        // Gets pelicoin balance
        function getBalance() external view returns (uint256){
            return pelicoin.balanceOf(address(this));
        }


    /* TRANSACTION INFORMATION */

        // Gets the amount of transactions in the transaction history
        function getTransactionsLength() external view returns (uint256){
            return transactionsManager.getTransactionHistoryLength();
        }

        // Gets the transaction from the transaction history at location "index"
         function getTransaction(uint256 index) external view returns (Transactions.Transaction memory){
            return transactionsManager.getTransaction(index);
        }

        // Gets the transaction history
        function getTransactionHistory() external view returns (Transactions.Transaction[] memory){
            return transactionsManager.getTransactionHistory();
        }

    
    /* PAUSE / UNPAUSE */

        // Triggers stopped state if and only if the contract is not paused.
        function pause()   external onlyOwner { _pause(); }

        // Returns to normal state if and only if the contract is paused
        function unpause() external onlyOwner { _unpause(); }
}