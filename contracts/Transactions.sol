// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Transactions is Ownable, ReentrancyGuard{

    using SafeMath for uint256;

    struct Transaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
    }


    mapping(address => Transaction[]) private transactionHistory;    // Transaction History


    function createTransaction(address from, address to, uint256 amount) external onlyOwner{
        
        require(from != address(0), "Transactions: sender cannot be zero address");
        require(to   != address(0), "Transactions: recipient cannot be zero address");
        require(amount > 0,         "Transactions: amount must be greater than zero");

        Transaction memory transaction = Transaction(from, to, amount, block.timestamp);
        transactionHistory[from].push(transaction);
        transactionHistory[to].push(transaction);
    }


    // Amount of transactions in the transaction history
    function getTransactionHistoryLength(address account) external view returns (uint256){
        return transactionHistory[account].length;
    }


    // Get transaction history
    function getTransactionHistory(address account) external view returns (Transaction[] memory){
        return transactionHistory[account];
    }
}