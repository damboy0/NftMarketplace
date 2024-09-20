# NFT Marketplace

The NFT Marketplace is a smart contract that allows users to mint, list, buy, and sell non-fungible tokens (NFTs). This project utilizes the OpenZeppelin library for secure smart contract development and implements features like token minting, listing, purchasing, and marketplace pausing.

## Features
- Mint NFTs: Users can create new NFTs by providing a token URI and setting a price.
- List NFTs for Sale: Owners can list their NFTs for sale at a specified price.
- Buy NFTs: Users can purchase listed NFTs using Ether.
- Marketplace Control: The owner of the marketplace can pause or unpause the contract for maintenance.
- Withdraw Funds: The contract owner can withdraw the balance of Ether from the contract.

# Installation

## Prerequisites
Make sure you have the following installed:

- Node.js
- npm or yarn
- Hardhat

## Getting Started

1. Clone the Repository:

```
git clone https://github.com/damboy0/nft-marketplace.git
cd nft-marketplace 
```

2. Install Dependencies:
``` 
npm install
```

3. Compile the Smart Contracts:
```
npx hardhat compile
```



## Testing

Tests are written using Mocha and Chai. Run the following command to execute the tests:

```
npx hardhat test
```


# License
This project is licensed under the MIT License.

