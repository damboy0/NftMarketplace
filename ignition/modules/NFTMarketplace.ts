import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const NFTMarketplaceModule = buildModule("NFTMarketplaceModule", (m) => {

    const save = m.contract("NFTMarketplace");

    return { save };
});

export default NFTMarketplaceModule;