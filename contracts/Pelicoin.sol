// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeliCoin is ERC20, Ownable{
    
    constructor() ERC20("PeliCoin", "PLC") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _transferFrom(address from, address to, uint256 amount) external{
        require((from == msg.sender) || (msg.sender == owner()));
        approve(to, amount);
        transferFrom(from, to, amount);
    }

}