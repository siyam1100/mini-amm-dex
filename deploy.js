const hre = require("hardhat");

async function main() {

  const Token = await hre.ethers.getContractFactory("Token");

  const tokenA = await Token.deploy("TokenA","TKA");
  await tokenA.waitForDeployment();

  const tokenB = await Token.deploy("TokenB","TKB");
  await tokenB.waitForDeployment();

  const DEX = await hre.ethers.getContractFactory("DEX");
  const dex = await DEX.deploy(
    await tokenA.getAddress(),
    await tokenB.getAddress()
  );
  await dex.waitForDeployment();

  console.log("TokenA:", await tokenA.getAddress());
  console.log("TokenB:", await tokenB.getAddress());
  console.log("DEX:", await dex.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
