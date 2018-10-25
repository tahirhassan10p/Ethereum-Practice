const HDWalletProvider = require("truffle-hdwallet-provider");
const ganache = require("ganache-cli");
const Web3 = require("web3");
const { interface, bytecode } = require("./compile");

const provider = new HDWalletProvider(
  "paddle describe borrow learn waste galaxy thing coil glare ride blush tent",
  "https://rinkeby.infura.io/2973843943c2469989fe785cdb78d48f"
);

const web3 = new Web3(provider);

// const web3 = new Web3(ganache.provider());

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attemping to deploy from account", accounts[0]);

  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({
      data: bytecode
    })
    .send({ gas: "1000000", from: accounts[0] });

  console.log(interface);
  console.log("Contract deployed to", result.options.address);
};

deploy();
