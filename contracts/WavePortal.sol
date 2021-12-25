// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  // This is a state variable and it´s stored permanently in contract storage
  uint256 total_waves;
  address [] participating_users;

  constructor() {
    console.log("Yo yo, I am a contract and I am smart");
  }

  function wave() public {
    total_waves += 1;
    console.log("%s has waved!", msg.sender);
    participating_users.push(msg.sender);
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

