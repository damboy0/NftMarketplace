// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract NFTMarketplace is ERC721URIStorage, Ownable(msg.sender), Pausable {
    uint256 private _tokenIds;

    struct NFT {
        uint256 tokenId;
        address payable creator;
        uint256 price;
        bool isListed;
    }

    mapping(uint256 => NFT) public nfts;

    event NFTMinted(uint256 indexed tokenId, address indexed creator, uint256 price);
    event NFTListed(uint256 indexed tokenId, uint256 price);
    event NFTBought(uint256 indexed tokenId, address indexed buyer, uint256 price);

    constructor() ERC721("NFTMarketplace", "NFTM") {}

    
    function mintNFT(string memory tokenURI, uint256 price) public whenNotPaused returns (uint256) {
        require(price > 0, "Price must be greater than 0");

        _tokenIds += 1;  
        uint256 newTokenId = _tokenIds;

        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);  //ERC721URIStorage's _setTokenURI

        nfts[newTokenId] = NFT({
            tokenId: newTokenId,
            creator: payable(msg.sender),
            price: price,
            isListed: true
        });

        emit NFTMinted(newTokenId, msg.sender, price);
        return newTokenId;
    }

   
    function listNFT(uint256 tokenId, uint256 price) public whenNotPaused {
        require(ownerOf(tokenId) == msg.sender, "Not the owner");
        require(price > 0, "Price must be greater than 0");

        nfts[tokenId].price = price;
        nfts[tokenId].isListed = true;

        emit NFTListed(tokenId, price);
    }

   
    function buyNFT(uint256 tokenId) public whenNotPaused payable {
        NFT memory nft = nfts[tokenId];
        require(nft.isListed, "NFT not for sale");
        require(msg.value >= nft.price, "Insufficient funds");

        address payable seller = payable(ownerOf(tokenId));
        _transfer(seller, msg.sender, tokenId);

        seller.transfer(msg.value);
        nfts[tokenId].isListed = false;

        emit NFTBought(tokenId, msg.sender, nft.price);
    }

    
    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    
    function pauseMarketplace() public onlyOwner {
        _pause();  
    }

    function unpauseMarketplace() public onlyOwner {
        _unpause();  
    }


    function getAllNFTs() public view returns (NFT[] memory) {
        uint256 totalNFTs = _tokenIds;
        NFT[] memory allNFTs = new NFT[](totalNFTs);

        uint256 currentIndex = 0;

        for (uint256 i = 1; i <= totalNFTs; i++) {
            if (nfts[i].tokenId != 0) {
                allNFTs[currentIndex] = nfts[i];
                currentIndex += 1;
            }
        }

        return allNFTs;
    }
}
