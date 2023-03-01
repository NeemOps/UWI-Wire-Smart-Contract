// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/security/Pausable.sol";

contract Transactions is Ownable, Pausable{

    using SafeMath for uint256;

    struct Transaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
    }


    mapping(address => Transaction[]) private transactionHistory;    // Transaction History


    function createTransaction(address from, address to, uint256 amount) external whenNotPaused onlyOwner{
        
        require(from != address(0), "Transactions: sender cannot be zero address");
        require(to   != address(0), "Transactions: recipient cannot be zero address");
        require(amount > 0,         "Transactions: amount must be greater than zero");

        Transaction memory transaction = Transaction(from, to, amount, block.timestamp);
        transactionHistory[msg.sender].push(transaction);
    }


    // Amount of transactions in the transaction history
    function getTransactionHistoryLength() external view returns (uint256){
        return transactionHistory[msg.sender].length;
    }

    // Get transaction history
    function getTransactionHistory() external view returns (Transaction[] memory){
        return transactionHistory[msg.sender];
    }

    // Get transaction at index
    function getTransaction(uint256 index) external view returns (Transaction memory){
        
        require(index < transactionHistory[msg.sender].length, "Transactions: index too high");

        return transactionHistory[msg.sender][index];
    }


    function pause()   external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
}