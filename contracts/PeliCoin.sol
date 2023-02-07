// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract PeliCoin {
    
    mapping(address => uint256) balances;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the owner can perform this action!");
        _;
    }

    function mint(address _to, uint _amount) public onlyOwner {
        balances[_to] += _amount;
    }

    function send(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

}