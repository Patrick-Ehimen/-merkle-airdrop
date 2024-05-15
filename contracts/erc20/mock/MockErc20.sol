// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title MockERC20
/// @dev A mock token for testing and simulations, based on the ERC20 standard.
contract MockERC20 is ERC20 {
    /// @dev Creates an instance of `MockERC20` with `amountToMint` tokens initially minted to the deployer's address.
    /// @param _name Name of the ERC20 token.
    /// @param _symbol Symbol of the ERC20 token.
    /// @param amountToMint Initial number of tokens to mint to the deployer's address.
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 amountToMint
    ) ERC20(_name, _symbol) {
        setBalance(msg.sender, amountToMint);
    }

    /// @notice Adjusts the token balance of `to` to `amount`, minting or burning the difference as required.
    /// @dev Mints tokens to the address `to` if `amount` is greater than current balance, or burns tokens if `amount` is less.
    /// @param to Address whose balance will be adjusted.
    /// @param amount The target end balance for the address `to`.
    function setBalance(address to, uint256 amount) public {
        uint256 old = balanceOf((to));
        if (old < amount) {
            _mint(to, amount - old);
        } else if (old > amount) {
            _burn(to, old - amount);
        }
    }
}
