# PeliCoin Token Contract
This is a Solidity smart contract for a ERC20 token called PeliCoin (PLC). The contract is based on the OpenZeppelin library, which provides various secure and tested implementations of smart contracts.

Usage
To use this contract, you can deploy it on a compatible blockchain using a development environment such as Remix or Truffle. The contract is compatible with Solidity version 0.8.9 or higher.

Once deployed, the contract will create a new ERC20 token with the symbol "PLC" and name "PeliCoin". The total supply of PeliCoin is set to 250 with 18 decimal places. The contract owner is the account that deployed the contract.

The contract provides a mint function that can be used by the contract owner to mint new PeliCoin tokens and transfer them to a specified account. The mint function takes two arguments: the address of the account to receive the tokens and the amount of tokens to mint.

License
This contract is licensed under the MIT License.