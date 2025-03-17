// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract PersonalizedNFTs {
    struct NFT {
        uint256 id;
        string name;
        string imageURI;
        address owner;
    }

    uint256 private nextId = 1;
    mapping(uint256 => NFT) public nfts;
    mapping(address => uint256[]) public ownerToNFTs;

    event Minted(uint256 id, string name, string imageURI, address owner);

    function mintNFT(string memory _name, string memory _imageURI) public {
        uint256 tokenId = nextId++;
        nfts[tokenId] = NFT(tokenId, _name, _imageURI, msg.sender);
        ownerToNFTs[msg.sender].push(tokenId);

        emit Minted(tokenId, _name, _imageURI, msg.sender);
    }

    function getNFT(uint256 _id) public view returns (NFT memory) {
        require(nfts[_id].id != 0, "NFT does not exist");
        return nfts[_id];
    }

    function getOwnerNFTs(address _owner) public view returns (uint256[] memory) {
        return ownerToNFTs[_owner];
    }
}
