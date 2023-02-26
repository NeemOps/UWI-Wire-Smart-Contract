// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Transactions is Ownable{

    using SafeERC20 for IERC20;

    IERC20 private pelicoin;

    event TokensReceived(address indexed from, uint256 amount);
    event TokensSent(address indexed to, uint256 amount);
    event TokensWithdrawn(uint256 amount);

    constructor(address pelicoinAddress){
        pelicoin = IERC20(pelicoinAddress);
    }

    function receiveTokens(uint256 amount) external{
        pelicoin.safeTransferFrom(msg.sender, address(this), amount);
        emit TokensReceived(msg.sender, amount);
    }

    function sendTokens(address to, uint256 amount) external onlyOwner{
        pelicoin.safeTransfer(to, amount);
        emit TokensSent(to, amount);
    }

    function withdrawTokens(uint256 amount) external onlyOwner{
        require(amount <= pelicoin.balanceOf(address(this)), "Insufficient balance");
        pelicoin.safeTransfer(owner(), amount);
        emit TokensWithdrawn(amount);
    }

    function balanceOf() external view returns (uint256){
        return pelicoin.balanceOf(address(this));
    }

    function getTokenAddress() external view returns (address){
        return address(pelicoin);
    }
}