// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {IERC20} from "./interfaces/IERC20.sol";
import {IMerkleDistributor} from "./interfaces/IMerkleDistributor.sol";
import {MerkleProof} from "./MerkleProof.sol";

contract MerkleDistributor is IMerkleDistributor {
    address public immutable i_tokens;
    bytes32 public immutable i_merkleRoot;
    address public owner;
    uint256 public expiryTime;

    mapping(uint256 => uint256) private claimedBitMap;

    /// @dev Initializes MerkleDistributor with token address, merkle root, expiration time and owner address
    constructor(
        address _token,
        bytes32 _merkleRoot,
        uint256 _expirationTime,
        address _owner
    ) {
        owner = _owner;
        i_tokens = _token;
        i_merkleRoot = _merkleRoot;
        expiryTime = block.timestamp + _expirationTime;
    }

    /// @notice Checks if an index has already been claimed
    /// @param index The index to check.
    /// @return True if claimed, false otherwise.
    function isClaimed(uint256 index) public view override returns (bool) {
        uint256 claimedWordIndex = index / 256;
        uint256 claimedBitIndex = index % 256;
        uint256 claimedWord = claimedBitMap[claimedBitIndex];
        uint256 mask = (1 << claimedBitIndex);

        return claimedWord & mask == mask;
    }

    /// @dev Sets the claimed flag for an index
    /// @param index The index to mark as claimed.
    function _setClaimed(uint256 index) private {
        uint256 claimedWordIndex = index / 256;
        uint256 claimedBitIndex = index % 256;
        claimedBitMap[claimedWordIndex] =
            claimedBitMap[claimedWordIndex] |
            (1 << claimedBitIndex);
    }

    /// @notice Claims airdropped tokens by proving inclusion in the Merkle root.
    /// @param index The index of the user's claim in the Merkle tree.
    /// @param account The address of the account claiming.
    /// @param amount The amount of tokens to claim.
    /// @param merkleProof The Merkle proof verifying the claim.
    function claim(
        uint256 index,
        address account,
        uint256 amount,
        bytes32[] calldata merkleProof
    ) external override {
        require(expiryTime > block.timestamp, "Expired");
        require(!isClaimed(index), "MerkleDistributor: Drop already claimed.");

        // Verify the merkle proof.
        bytes32 node = keccak256(abi.encodePacked(index, account, amount));
        require(
            MerkleProof.verify(merkleProof, i_merkleRoot, node),
            "MerkleDistributor: Invalid proof."
        );

        // Mark it claimed and send the token.
        _setClaimed(index);
        require(
            IERC20(i_tokens).transfer(account, amount),
            "MerkleDistributor: Transfer failed."
        );

        emit Claimed(index, account, amount);
    }

    /// @notice Allows the owner to claim remaining tokens after the expiration time.
    /// @param to The address to send the remaining tokens to.
    /// @return True if successful.
    function claimRestTokens(address to) public returns (bool) {
        // only owner
        require(expiryTime < block.timestamp, "Not expired yet");
        require(msg.sender == owner);
        require(IERC20(i_tokens).balanceOf(address(this)) >= 0);
        require(
            IERC20(i_tokens).transfer(
                to,
                IERC20(i_tokens).balanceOf(address(this))
            )
        );

        return true;
    }
}
