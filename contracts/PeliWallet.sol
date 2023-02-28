// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import "@openzeppelin/contracts/security/Pausable.sol";


contract PeliWallet is Ownable, Pausable {

    using Address for address;


    event Transferred(address indexed to, uint256 value);
    event Withdrawn(uint256 value);


    // Transfer Pelicoin tokens
    function transferTokens(IERC20 pelicoin, address to, uint256 amount) external onlyOwner {
       
        require(to != address(0), "PeliWallet: recipient cannot be zero address");
        require(amount > 0, "PeliWallet: amount must be greater than zero");

        pelicoin.transferFrom(msg.sender, to, amount);
        require(pelicoin.transfer(to, amount), "PeliWallet: Transfer Failed");
        emit Transferred(to, amount);
    }


    // Withdraw Pelicoin tokens
    function withdraw(IERC20 token, uint256 amount) external whenNotPaused onlyOwner{
        
        require(amount <= token.balanceOf(msg.sender), "PeliWallet: Insufficient balance");
       
        token.transfer(msg.sender, amount);
        emit Withdrawn(amount);
    }


    function balanceOf(IERC20 token, address account) external view returns (uint256){
        return token.balanceOf(account);
    }

    function pause()   external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }
}