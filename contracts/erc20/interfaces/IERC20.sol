// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

interface IERC20 {
    /// @notice Returns the total token supply
    function totalSupply() external view returns (uint256);

    /// @notice Returns the amount of tokens held by the specified address
    /// @param account The address of the token holder
    /// @return The balance of tokens held
    function balanceOf(address account) external view returns (uint256);

    /// @notice Transfers amount of tokens to the specified address
    /// @param recipient The address to which the tokens are transferred
    /// @param amount The number of tokens to transfer
    /// @return Returns true if the operation was successful
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /// @notice Returns the remaining number of tokens that the spender is allowed to spend on behalf of the owner
    /// @param owner The address of the token owner
    /// @param spender The address of the token spender
    /// @return The number of tokens available for the spender
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /// @notice Approves the spender to spend a specific amount of tokens on behalf of the caller
    /// @param spender The address which will spend the funds
    /// @param amount The amount of tokens to be allowed
    /// @return Returns true if the operation was successful
    function approve(address spender, uint256 amount) external returns (bool);

    /// @notice Transfers tokens from one specified address to another using the allowance mechanism
    /// @param sender The address from which the tokens are transferred
    /// @param recipient The address to which the tokens are transferred
    /// @param amount The number of tokens to transfer
    /// @return Returns true if the operation was successful
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /// @dev Emitted when `value` tokens are moved from one account (`from`) to another (`to`)
    /// @param from The address from which the tokens have been transferred
    /// @param to The address to which the tokens have been transferred
    /// @param value The number of tokens transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    /// @dev Emitted when an approval is given to `spender` by `owner` for `value` tokens
    /// @param owner The address of the token owner who approved
    /// @param spender The address of the token spender who was approved
    /// @param value The amount of tokens that are approved
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
