// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

/// @title MerkleProof Library
/// @notice This library provides functions to verify Merkle proofs, allowing one to validate the inclusion of a leaf in a Merkle tree.
library MerkleProof {
    /// @notice Verifies the inclusion of a leaf in a Merkle tree given a proof and the root.
    /// @param proof An array of bytes32 hashes that represent the Merkle proof.
    /// @param root The root hash of the Merkle tree.
    /// @param leaf The hash of the leaf whose inclusion is being verified.
    /// @return bool Returns `true` if the leaf is part of the tree, otherwise returns `false`.
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool) {
        bytes32 computedHash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (computedHash <= proofElement) {
                computedHash = keccak256(
                    abi.encodePacked(computedHash, proofElement)
                );
            } else {
                computedHash = keccak256(
                    abi.encodePacked(proofElement, computedHash)
                );
            }
        }

        return computedHash == root;
    }
}
