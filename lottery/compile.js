const path = require("path");
const fs = require("fs");
const solc = require("solc");

const bloodChainPath = path.resolve(__dirname, "contracts", "BloodChain.sol");
const source = fs.readFileSync(bloodChainPath, "utf8");

module.exports = solc.compile(source, 1).contracts[":BloodChain"];
