// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Transactions is Ownable, ReentrancyGuard {
    
    using Address for address;


    struct Transaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
    }


    Transaction[] public transactionHistory;    // Transaction History
    IERC20 private pelicoin;


    constructor(address pelicoinAddress){
        pelicoin = IERC20(pelicoinAddress);
    }


    // Receive Pelicoin tokens
    function receiveTokens(uint256 amount) external nonReentrant {

        require(amount > 0, "Amount must be greater than zero");
        pelicoin.transferFrom(msg.sender, address(this), amount);

        transactionHistory.push(Transaction(msg.sender, address(this), amount, block.timestamp));
    }

    // Send Pelicoin tokens to another address
    function sendTokens(address to, uint256 amount) external onlyOwner nonReentrant {

        require(to != address(0), "Invalid recipient address");
        require(to != address(this));

        pelicoin.transfer(to, amount);

        transactionHistory.push(Transaction(address(this), to, amount, block.timestamp));
    }


    // Withdraw Pelicoin tokens to the owner of the smart contract
    function withdrawTokens(uint256 amount) external onlyOwner nonReentrant {

        require(amount <= pelicoin.balanceOf(address(this)), "Insufficient balance");
        pelicoin.transfer(owner(), amount);

        transactionHistory.push(Transaction(address(this), owner(), amount, block.timestamp));
    } 


    // Balance in the smart contract
    function balanceOf() external view returns (uint256){
        return pelicoin.balanceOf(address(this));
    }


    // Get Pelicoin token address
    function getTokenAddress() external view returns (address){
        return address(pelicoin);
    }


    // Amount of transactions in the transaction history
    function getTransactionHistoryLength() external view returns (uint256){
        return transactionHistory.length;
    }


    // Get transaction at the given index
    function getTransaction(uint256 index) external view returns (Transaction memory){
        require(index < transactionHistory.length, "Invalid transaction index");
        return transactionHistory[index];
    }
}