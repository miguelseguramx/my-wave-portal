const main = async () => {
  // In order to deploy something to the blockchain, we need to have a wallet address!
  // Hardhat does this for us magically in the background.
  // But here I grabbed the wallet address of contract owner and
  // I also grabbed a random wallet address and called it randomPerson.
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  // Hardhat will create a local Ethereum network for us, but just for this contract.
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address)

  let waveCount;
  let latestParticipant;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave();
  await waveTxn.wait();

  waveCount = await waveContract.getTotalWaves();
  latestParticipant = await waveContract.getLatestParticipant();
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
}

runMain()
