// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";


contract Roles is AccessControlEnumerable{

    bytes32 public constant ADMIN_ROLE  = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE   = keccak256("USER_ROLE");
    bytes32 public constant VENDOR_ROLE = keccak256("VENDOR_ROLE");


    constructor() {
        _setupRole(ADMIN_ROLE, msg.sender);
    }


    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender));
        _;
    }
    
    modifier onlyUser() {
        require(hasRole(USER_ROLE, msg.sender));
        _;
    }
    
    modifier onlyVendor() {
        require(hasRole(VENDOR_ROLE, msg.sender));
        _;
    }
}