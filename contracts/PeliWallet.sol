// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import "@openzeppelin/contracts/security/Pausable.sol";


contract PeliWallet is Ownable, Pausable {

    using Address for address;

    event Deposited(address indexed from, uint256 value);
    event Sent(address indexed to, uint256 value);
    event Withdrawn(uint256 value);


    mapping(address => uint256) private _balances;


    // Receive Pelicoin tokens
    function deposit(IERC20 pelicoin, uint256 amount) external whenNotPaused {

        require(amount > 0, "Amount must be greater than zero");

        pelicoin.transferFrom(msg.sender, address(this), amount);
        _balances[msg.sender] += amount;

        emit Deposited(msg.sender, amount);
    }


    // Send Pelicoin tokens
    function send(IERC20 pelicoin, address to, uint256 amount) external whenNotPaused{

        require(to != address(0), "Invalid recipient address");

        pelicoin.transfer(to, amount);
        _balances[msg.sender] -= amount;

        emit Sent(to, amount);
    }


    // Withdraw Pelicoin tokens
    function withdraw(IERC20 pelicoin, uint256 amount) external whenNotPaused onlyOwner{
        
        require(amount <= _balances[msg.sender], "Insufficient balance");
       
        pelicoin.transfer(msg.sender, amount);
        _balances[msg.sender] -= amount;

        emit Withdrawn(amount);
    }


    function balanceOf(address account) external view returns (uint256){
        return _balances[account];
    }

    function pause()   external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
}