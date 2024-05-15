// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {MerkleDistributor} from "./MerkleDistributor.sol";

contract MerkleDistributorFactory {
    /// @notice Keep track of all created MerkleDistributor contracts.
    MerkleDistributor[] public distributors;

    /// @dev Emit when a new distributor is created, providing its address.
    event DistributorCreated(address indexed distributorAddress);

    /// @notice Create a new MerkleDistributor contract instance.
    /// @param token The ERC20 token distributed by the MerkleDistributor.
    /// @param merkleRoot The root of the Merkle tree for distribution.
    /// @param _duration The duration for which the distribution is active.
    /// @param owner The owner who is initiating the distributor contract.
    function createDistributor(
        address token,
        bytes32 merkleRoot,
        uint _duration,
        address owner
    ) public {
        MerkleDistributor distributor = new MerkleDistributor(
            token,
            merkleRoot,
            _duration,
            msg.sender
        );
        distributors.push(distributor);
        emit DistributorCreated(address(distributor));
    }

    /// @notice Get a specific MerkleDistributor contract by index.
    /// @param index The index of the distributor in the array.
    /// @return The MerkleDistributor contract at the specified index.
    function getDistributor(
        uint index
    ) public view returns (MerkleDistributor) {
        require(index < distributors.length, "Index out of bounds");
        return distributors[index];
    }

    /// @notice Get the total count of distributed MerkleDistributors.
    /// @return The count of MerkleDistributor contracts created.
    function getDistributorsCount() public view returns (uint) {
        return distributors.length;
    }
}
