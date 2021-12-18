// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

require("dotenv").config();

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  /*
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 cap_,
        uint256 initialBalance_,
        address payable feeReceiver_
   */
  const BEP20SmartContract = await hre.ethers.getContractFactory(process.env.CONTRACT_NAME);
  const bep20SmartContract = await BEP20SmartContract.deploy(
      process.env.TOKEN_NAME,
      process.env.TOKEN_SYMBOL,
      process.env.TOKEN_DECIMALS,
      process.env.TOKEN_CAP_SUPPLY,
      process.env.TOKEN_INI_SUPPLY,
      process.env.ADDRESS_1,
      process.env.ADDRESS_2
  );

  await bep20SmartContract.deployed();

  console.log(`${process.env.TOKEN_NAME} deployed to:`, bep20SmartContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
