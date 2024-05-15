# MerkleDistributor Project

## Overview

The MerkleDistributor project is a Solidity-based system designed to distribute ERC20 tokens using a Merkle Tree for proof verification. This ensures that tokens can only be claimed by addresses included in the Merkle Tree, preventing unauthorized access to the token distribution.

## Components

### MerkleDistributor Contract

Located at contracts/erc20/MerkleDistributor.sol, this contract handles the distribution of tokens. It allows users to claim tokens if they can provide a valid Merkle proof that their claim is included in the Merkle root.

Key functionalities:

- **Claim Tokens**: Users can claim their tokens by providing a valid index, account address, token amount, and Merkle proof.
- **Check Claim Status**: Users can check whether a particular index has already been claimed.
- **Claim Remaining Tokens**: After the distribution has expired, the owner can claim any remaining tokens.

### MerkleProof Library

Located at contracts/erc20/MerkleProof.sol, this library provides functions to verify Merkle proofs, which are essential for validating claims in the MerkleDistributor contract.

### Interfaces

- **IERC20**: Standard ERC20 interface used for token interactions.
- **IMerkleDistributor**: Interface for the MerkleDistributor, defining essential functions and events.

### Factory Contract

Located at contracts/erc20/MerkleDistributorFactory.sol, this contract allows for the creation of multiple MerkleDistributor instances, managing them through an array.

### Mock Contracts

For testing purposes, a mock ERC20 token contract MockERC20

## Usage Example

To create a new MerkleDistributor:

```solidity
MerkleDistributorFactory factory = new MerkleDistributorFactory();
factory.createDistributor(tokenAddress, merkleRoot, duration, ownerAddress);
```

To claim tokens:

```solidity
merkleDistributor.claim(index, account, amount, merkleProof);
```

This project leverages the security and efficiency of Merkle Trees for token distribution, ensuring a transparent and fair process for ERC20 token claims.
