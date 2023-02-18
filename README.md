# PeliCoin Token Contract
This is a Solidity smart contract for a ERC20 token called PeliCoin (PLC). The contract is based on the OpenZeppelin library, which provides various secure and tested implementations of smart contracts. The smart contract inherits from the ERC20 standard and Ownable, which allows for ownership control over the smart contract.


## License
This contract is licensed under the MIT License.


## Usage
To use this contract, you can deploy it on a compatible blockchain using a development environment such as Remix or Truffle. The contract is compatible with Solidity version 0.8.9 or higher.

Once deployed, the contract will create a new ERC20 token with the symbol "PLC" and name "PeliCoin". The contract owner is the account that deployed the contract.

## Functions:
1. **constructor()**

- Parameters: none
- Description: Constructor function to initialize the ERC20 token with the name "PeliCoin" and symbol "PLC".
2. **mint(address to, uint256 amount)**

Parameters:
to (address): The address to mint the tokens to.
amount (uint256): The amount of tokens to mint.
Description: Mint a specified amount of PeliCoin tokens to the specified address. This function can only be called by the owner of the smart contract.
## Inherited Functions:
PeliCoin inherits functions from the ERC20 and Ownable contracts. The following functions are available:

1. **ERC20**:

**balanceOf(address account) public view returns (uint256)**: Returns the balance of the specified address.
**transfer(address recipient, uint256 amount) public returns (bool)**: Transfer a specified amount of tokens to the specified recipient.
**allowance(address owner, address spender) public view returns (uint256)**: Returns the amount of tokens that the spender is allowed to spend on behalf of the owner.
**approve(address spender, uint256 amount) public returns (bool)**: Allow the spender to spend the specified amount of tokens on behalf of the caller.
**transferFrom(address sender, address recipient, uint256 amount) public returns (bool)**: Transfer a specified amount of tokens from the sender to the recipient. The spender must have been granted allowance to spend tokens on behalf of the sender.
2. **Ownable**:
- **owner() public view returns (address)**: Returns the address of the owner of the smart contract.
- **renounceOwnership() public onlyOwner**: Allows the current owner to renounce their ownership of the smart contract.
- **transferOwnership(address newOwner) public onlyOwner**: Allows the current owner to transfer their ownership to a new address.
