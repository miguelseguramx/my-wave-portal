const main = async () => {
  // In order to deploy something to the blockchain, we need to have a wallet address!
  // Hardhat does this for us magically in the background.
  // But here I grabbed the wallet address of contract owner and
  // I also grabbed a random wallet address and called it randomPerson.
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  // Hardhat will create a local Ethereum network for us, but just for this contract.
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address)

  /*
  * Get Contract balance
  */
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );


  let waveCount;
  let latestParticipant;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  /**
   * Let's send a few waves!
   */
  let waveTxn = await waveContract.wave("A message!");
  await waveTxn.wait(); // Wait for the transaction to be mined

  waveTxn = await waveContract.connect(randomPerson).wave("Another message!");
  await waveTxn.wait(); // Wait for the transaction to be mined

  let waveTxn = await waveContract.wave("A second message!");
  await waveTxn.wait(); // Wait for the transaction to be mined

  /*
  * Get Contract balance to see what happened!
  */
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);

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
