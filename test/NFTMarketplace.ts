import {
    time,
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
  import { expect } from "chai";
  import hre from "hardhat";

  describe("NftMarketplace" , async function(){

    async function deployNFTMarketplace() {
        const [owner, buyer, creator] = await hre.ethers.getSigners();
        const NFTMarketplace = await hre.ethers.getContractFactory("NFTMarketplace");
        const marketplace = await NFTMarketplace.deploy();
        // await marketplace.deployed();
    
        return { marketplace, owner, buyer, creator };
      }
      describe("Minting NFTs", function () {
    
        it("Should revert if price is 0", async function () {
          const { marketplace, creator } = await loadFixture(deployNFTMarketplace);
          await expect(
            marketplace.connect(creator).mintNFT("ipfs://token-uri", 0)
          ).to.be.revertedWith("Price must be greater than 0");
        });


        it("Should mint a new NFT and store the details", async function () {
            const { marketplace, creator } = await loadFixture(deployNFTMarketplace);
            const price = hre.ethers.parseUnits("1", 18);
            const tokenURI = "ipfs://token-uri";

            const txResponse = await marketplace.connect(creator).mintNFT(tokenURI, price);
            
            const txReceipt = await txResponse.wait();
            // const tokenId = txReceipt.events[0].args.tokenId;
	        //  const tokenId = txReceipt?.logs[0].topics;
          

            const nft = await marketplace.nfts(1n);



            console.log(nft.creator,nft.price, nft.isListed);
            expect(nft.creator).to.equal(creator.address);
            expect(nft.price).to.equal(price);
            expect(nft.isListed).to.equal(true);
    });
    
      });
    
    

  });