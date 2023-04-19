// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Roles.sol";

contract RolesManager is Roles{

    Roles public roles;


    constructor (Roles _roles){
        roles = _roles;
    }


    function grantAdminRole(address account) public onlyAdmin{
        grantRole(ADMIN_ROLE, account);
    }
    
    function revokeAdminRole(address account) public onlyAdmin{
        revokeRole(ADMIN_ROLE, account);
    }
    
    function grantUserRole(address account) public onlyAdmin{
        grantRole(USER_ROLE, account);
    }
    
    function revokeUserRole(address account) public onlyAdmin{
        revokeRole(USER_ROLE, account);
    }
    
    function grantVendorRole(address account) public onlyAdmin{
        grantRole(VENDOR_ROLE, account);
    }
    
    function revokeVendorRole(address account) public onlyAdmin{
        revokeRole(VENDOR_ROLE, account);
    }
}