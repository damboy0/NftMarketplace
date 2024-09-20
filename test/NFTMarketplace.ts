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
        await marketplace.deployed();
    
        return { marketplace, owner, buyer, creator };
      }

    

  });