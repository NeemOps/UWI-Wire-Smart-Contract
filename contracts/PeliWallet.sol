// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PeliWallet is Ownable, Pausable {
    using SafeMath for uint256;

    uint256 constant BALANCE_LIMIT = 10 ether;

    constructor(){}

    receive() external payable{}

    function withdraw(uint _amount) external onlyOwner whenNotPaused {
        require(address(this).balance >= _amount, "Insufficient balance in wallet");
        payable(msg.sender).transfer(_amount);
    }

    function deposit() external payable whenNotPaused {
        // use SafeMath to prevent overflow
        uint256 newBalance = address(this).balance.add(msg.value);
        require(newBalance <= BALANCE_LIMIT, "Wallet balance limit reached");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}
