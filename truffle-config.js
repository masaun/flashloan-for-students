require('dotenv').config();

//const mnemonic = process.env.MNENOMIC;
const HDWalletProvider = require("truffle-hdwallet-provider");


module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,     // Ganache-GUI
      //port: 8545,   // Ganache-CLI
      network_id: "*",
    },
    kovan: {
      provider: function() {
        return new HDWalletProvider(process.env.MNEMONIC, process.env.RPC_URL_KOVAN)
        //return new HDWalletProvider("Put your Mnemonic word in here", process.env.RPC_URL_KOVAN)  // If Mnemonic is not recognized, you put your Mnemonic word directly. 
      },
      network_id: '42',
      gas: 4465030,
      gasPrice: 10000000000,
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(process.env.MNEMONIC, process.env.RPC_URL_ROPSTEN)
      },
      network_id: '3',
      gas: 4465030,
      gasPrice: 10000000000,
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(process.env.MNENOMIC, process.env.RPC_URL_RINKEBY);
      },
      network_id: '4',
      gas: 3000000,
      gasPrice: 10000000000,
    },
    main: {
      provider: () => new HDWalletProvider(process.env.MNENOMIC, "https://mainnet.infura.io/v3/" + process.env.INFURA_API_KEY),
      network_id: 1,
      gas: 3000000,
      gasPrice: 10000000000
    },
    skale: {
        provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, process.env.SKALE_CHAIN_TRUFFLE),
        gasPrice: 0,
        network_id: "*"
    }
  }
};
