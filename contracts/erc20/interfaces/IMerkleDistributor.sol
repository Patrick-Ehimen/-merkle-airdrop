// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

interface IMerkleDistributor {
    /// @notice Returns the token address associated with the distributor
    function token() external view returns (address);

    /// @notice Returns the Merkel root of the distributor
    function merkelRoot() external view returns (bytes32);

    /// @notice Determines if the claim with given index has already been done
    /// @param index the index to check for whether claim has been made
    /// @return true if the claim was already made, otherwise false
    function isClaimed(uint256 index) external view returns (bool);

    /// @notice Allows a user to claim a distribution
    /// @param index the index of the claim in the Merkle tree
    /// @param account the account address making the claim
    /// @param amount the amount being claimed
    /// @param merkleProof the Merkle Proof required to prove the claim
    function claim(
        uint256 index,
        address account,
        uint256 amount,
        bytes32[] calldata merkleProof
    ) external;

    /// @notice Emitted when a claim is successfully processed
    /// @param index the index of the claim in the Merkle tree
    /// @param account the account that received the claim
    /// @param amount the amount that was claimed
    event Claimed(uint256 index, address account, uint256 amount);
}
