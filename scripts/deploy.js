// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const SolidityGlobalVariables = await hre.ethers.getContractFactory("solidityGlobalVariables");
  const AbiEncodeDecode = await hre.ethers.getContractFactory("abiEncodeDecode");
  const OtherGlobal = await hre.ethers.getContractFactory("otherGlobal");
  const solidityGlobalVariables = await SolidityGlobalVariables.deploy();
  const abiEncodeDecode = await AbiEncodeDecode.deploy();
  const otherGlobal = await OtherGlobal.deploy();

  await solidityGlobalVariables.deployed();
  await abiEncodeDecode.deployed();
  await otherGlobal.deployed();

  console.log("solidityGlobalVariables contract is deployed on: ", solidityGlobalVariables.address);
  console.log("AbiEncodeDecode contract is deployed on: ", abiEncodeDecode.address);
  console.log("OtherGlobal contract is deployed on: ", abiEncodeDecode.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
