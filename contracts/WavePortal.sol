// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  // This is a state variable and it´s stored permanently in contract storage
  uint256 total_waves;
  uint256 private seed;
  address [] participating_users;

  /*
   * A little magic, Google what events are in Solidity!
   */
  event NewWave(address indexed from, uint256 timestamp, string message);

  /*
    * I created a struct here named Wave.
    * A struct is basically a custom datatype where we can customize what we want to hold inside it.
    */
  struct Wave {
    address waver; // The address of the user who waved.
    string message; // The message the user sent.
    uint256 timestamp; // The timestamp when the user waved.
  }

  /*
   * I declare a variable waves that lets me store an array of structs.
   * This is what lets me hold all the waves anyone ever sends to me!
   */
  Wave[] waves;

  /*
  * This is an address => uint mapping, meaning I can associate an address with a number!
  * In this case, I'll be storing the address with the last time the user waved at us.
  */
  mapping(address => uint256) public lastWavedAt;

  constructor() payable {
    console.log("Yo yo, I am a contract and I am smart");
    //  * Set the initial seed
    seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
    //  * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
    require(
        lastWavedAt[msg.sender] + 30 minutes < block.timestamp,
        "Wait 30m"
    );
    //  * Update the current timestamp we have for the user
    lastWavedAt[msg.sender] = block.timestamp;

    total_waves += 1;
    console.log("%s waved w/ message %s", msg.sender, _message);

    //  * This is where I actually store the wave data in the array.
    waves.push(Wave(msg.sender, _message, block.timestamp));


    /*
     * Generate a new seed for the next user that sends a wave
     */
    seed = (block.difficulty + block.timestamp + seed) % 100;
    if (seed <= 50) {
      console.log("%s won!", msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
          prizeAmount <= address(this).balance,
          "Trying to withdraw more money than they contract has."
      );

      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract.");
    }

    emit NewWave(msg.sender, block.timestamp, _message);
    console.log("%s has waved!", msg.sender);
    participating_users.push(msg.sender);
  }

  //  * getAllWaves will return the struct array, waves, to us.
  function getAllWaves() public view returns (Wave[] memory) {
      return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", total_waves);
    return total_waves;
  }

  function getLatestParticipant() public view returns (address) {
    console.log("The latest participant is %s!", participating_users[participating_users.length - 1]);
    return participating_users[participating_users.length - 1];
  }
}

