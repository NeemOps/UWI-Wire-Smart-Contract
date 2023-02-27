// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

import "./Transactions.sol";

contract TokenWallet is Ownable, Pausable {
    using SafeERC20 for IERC20;

    Transactions private _transactions;

    event Deposited(address indexed from, uint256 value);
    event Sent(address indexed to, uint256 value);
    event Withdrawn(uint256 value);

    constructor(address pelicoinAddress) {
        _transactions = Transactions(pelicoinAddress);
    }

    function deposit(uint256 value) external whenNotPaused {
        _transactions.receiveTokens(value);
        emit Deposited(msg.sender, value);
    }

    function send(address to, uint256 value) external whenNotPaused {
        _transactions.sendTokens(to, value);
        emit Sent(to, value);
    }

    function withdraw(uint256 value) external whenNotPaused onlyOwner {
        _transactions.withdrawTokens(value);
        emit Withdrawn(value);
    }

    function balanceOf() external view returns (uint256) {
        return _transactions.balanceOf();
    }

    function getTokenAddress() external view returns (address) {
        return _transactions.getTokenAddress();
    }

    function pause() external onlyOwner { _pause(); }

    function unpause() external onlyOwner { _unpause(); }
}