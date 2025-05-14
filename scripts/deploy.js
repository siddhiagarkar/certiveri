// STEP 3

const hre = require("hardhat");

async function main() {
  const CertificateVerification = await hre.ethers.getContractFactory('CertificateVerification');
  const contract = await CertificateVerification.deploy();

  await contract.waitForDeployment();

  console.log("Contract deployed to:", await contract.getAddress());
  //the smart contract gets deployed on the blockchain network. and you get an address using which 
  //you can use the functions in the contract
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});