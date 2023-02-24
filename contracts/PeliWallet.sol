// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PeliWallet is Ownable{


    constructor(){}

    receive() external payable{} //special function

    function withdraw(uint _amount) external onlyOwner{
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}