// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PeliCoin is ERC20{
    
    mapping(address => uint256) balances;
    address public owner;

    constructor() ERC20("PeliCoin", "PLC"){
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