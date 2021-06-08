import { Contract } from "@ethersproject/contracts";
// We require the Hardhat Runtime Environment explicitly here. This is optional but useful for running the
// script in a standalone fashion through `node <script>`. When running the script with `hardhat run <script>`,
// you'll find the Hardhat Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

import { Locker__factory , AttackLocker__factory } from "../typechain";

async function main(): Promise<void> {
  const Locker: Locker__factory = await ethers.getContractFactory("Locker");
  const locker: Contract = await Locker.deploy();
  await locker.deployed();

  console.log("Locker deployed to: ", locker.address);

  const AttackerLocker: AttackLocker__factory = await ethers.getContractFactory("AttackLocker");
  const attackLocker: Contract = await AttackerLocker.deploy("0x44C93b7bA264c47Bf038d89a2B5Ac990B8dA563E" , locker.address, {value: "0xed"});
  await attackLocker.deployed();

  console.log("Attacker deployed to: ", attackLocker.address);

}

// We recommend this pattern to be able to use async/await everywhere and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
