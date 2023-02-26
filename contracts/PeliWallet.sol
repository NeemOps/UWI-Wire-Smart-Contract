pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract TokenWallet is Ownable, Pausable {
    using SafeERC20 for IERC20;

    Transactions private _transactions;

    event Deposit(address indexed from, uint256 value);
    event Withdrawal(address indexed to, uint256 value);

    constructor(address transactionsAddress) {
        _transactions = Transactions(transactionsAddress);
    }

    function deposit(uint256 value) external whenNotPaused {
        _transactions.receiveTokens(value);
        emit Deposit(msg.sender, value);
    }

    function withdraw(uint256 value) external whenNotPaused onlyOwner {
        _transactions.sendTokens(msg.sender, value);
        emit Withdrawal(msg.sender, value);
    }

    function balanceOf() external view returns (uint256) {
        return _transactions.balanceOf();
    }

    function getTokenAddress() external view returns (address) {
        return _transactions.getTokenAddress();
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}