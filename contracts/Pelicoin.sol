// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract PeliCoin is ERC20, Ownable, ERC20Burnable {

    using SafeERC20 for IERC20;
    
    mapping(address => bool) public authorizedOwners;


    uint256 public tetherPrice  = 1;   

    
    constructor() ERC20("PeliCoin", "PLC") {
        addAuthorizedOwner(msg.sender);
    }


    /* MINT TOKENS TO AN ADDRESS */
        function mint(address to, uint256 amount) public onlyAuthorizedOwner(){    

            amount = amount/tetherPrice;

            _mint(to, amount);
        }


    /* OWNER AUTHORIZATION */
        function addAuthorizedOwner(address newOwner) public onlyOwner{
            authorizedOwners[newOwner] = true;
        }

        function removeAuthorizedOwner(address ownerToRemove) public onlyOwner{
            authorizedOwners[ownerToRemove] = false;
        }

        modifier onlyAuthorizedOwner(){
            require(authorizedOwners[msg.sender], "Pelicoin: only authorized owners.");
            _;
        }


    /* UPDATE USDT PRICE */
    function setTetherPrice(uint256 newTetherPrice) public onlyAuthorizedOwner{
        tetherPrice = newTetherPrice;
    }
}