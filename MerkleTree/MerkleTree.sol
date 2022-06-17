// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "MerkleProof.sol";

contract MerkleTree{

    using MerkleProof for bytes32[];
    
    function mtVerify(bytes32[] memory proof, bytes32 root, bytes32 leaf) 
        public pure 
        returns (bool){
            return proof.verify(root, leaf);
    } 

    function rebuitRoot(bytes32[] memory proof, bytes32 leaf) 
        public pure 
        returns (bytes32){
            return proof.processProof(leaf);
    }
}