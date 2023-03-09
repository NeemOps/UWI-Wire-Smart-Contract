// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeliCoin is ERC20, Ownable{
    
    mapping(address => bool) public authorizedOwners;

    
    constructor() ERC20("PeliCoin", "PLC") {}


    // Only authorized owners modifier
    modifier onlyAuthorizedOwner() {
        require(authorizedOwners[msg.sender], "Pelicoin: only authorized owners.");
        _;
    }

    // Mints tokens to an address
    function mint(address to, uint256 amount) public onlyAuthorizedOwner() {
        _mint(to, amount);
    }
    

    /* UPDATED AUTHORIZED OWNERS */

        function addAuthorizedOwner(address newOwner) public onlyOwner {
            authorizedOwners[newOwner] = true;
        }

        function removeAuthorizedOwner(address ownerToRemove) public onlyOwner {
            authorizedOwners[ownerToRemove] = false;
        }
}