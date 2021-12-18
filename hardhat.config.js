require("dotenv").config();

// console.log(process.env);

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: process.env.NETWORK,
  networks: {
    localhost: {
      url: process.env.URL_LOCAL_HOST_URL + ":" + process.env.URL_LOCAL_PORT,
    },
    ropsten: {
      url: process.env.URL_ETH_ROPSTEN + process.env.INFURA_API_KEY || "",
      chainId: 3,
      accounts:
        process.env.PRIVATE_KEY !== undefined
          ? [process.env.DEPLOYMENT_ACCOUNT_KEY]
          : [],
    },
    rinkeby: {
      url: process.env.URL_ETH_RINKEBY + process.env.INFURA_API_KEY || "",
      chainId: 4,
      accounts:
        process.env.PRIVATE_KEY !== undefined
          ? [process.env.DEPLOYMENT_ACCOUNT_KEY]
          : [],
    },
    kovan: {
      url: process.env.URL_ETH_KOVAN + process.env.INFURA_API_KEY || "",
      chainId: 42,
      accounts:
        process.env.PRIVATE_KEY !== undefined
          ? [process.env.DEPLOYMENT_ACCOUNT_KEY]
          : [],
    },
    mainnet: {
      url: process.env.URL_ETH_MAINNET + process.env.INFURA_API_KEY || "",
      chainId: 1,
      accounts:
        process.env.PRIVATE_KEY !== undefined
          ? [process.env.DEPLOYMENT_ACCOUNT_KEY]
          : [],
    },
    bsc_testnet: {
      url: process.env.URL_BSC_TESTNET,
      chainId: 97,
      gasPrice: 20000000000,
      accounts: { mnemonic: process.env.MNEMONIC },
    },
    bsc_mainnet: {
      url: process.env.URL_BSC_MAINNET,
      chainId: 56,
      gasPrice: 20000000000,
      accounts: { mnemonic: process.env.MNEMONIC },
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey:
      process.env.BLOCKCHAIN === "ETH"
        ? process.env.ETHERSCAN_API_KEY
        : process.env.BSCSCAN_API_KEY,
  },
  solidity: {
    compilers: [
      {
        version: process.env.SOLC_VERSION_1,
        settings: {},
      },
      {
        version: process.env.SOLC_VERSION_2,
        settings: {},
      },
      {
        version: process.env.SOLC_VERSION_3,
        settings: {},
      },
      {
        version: process.env.SOLC_VERSION_4,
        settings: {},
      },
      {
        version: process.env.SOLC_VERSION_5,
        settings: {},
      },
    ],
    overrides: {
      "contracts/SwappsToken.sol": {
        version: process.env.SOLC_VERSION_1,
        settings: { }
      },
      "contracts/token/BEP20/lib/BEP20Operable.sol": {
        version: process.env.SOLC_VERSION_1,
        settings: { }
      },
    },
    optimizer: {
      enabled: process.env.OPTIMIZER_ENABLED === 1,
      runs: process.env.OPTIMIZER_RUNS,
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: process.env.MOCHA_TIMEOUT,
  },
};
