// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract PeliWallet{

    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable{} //special function

    function withdraw(uint _amount) external{
        require(msg.sender == owner, "Only owner can call this method");
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}