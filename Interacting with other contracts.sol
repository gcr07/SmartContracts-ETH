
//Interacting with other contracts se tiene que crear una interfaz y dentro la pura funcion ejemplo:

contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}


contract NumberInterface { // Importante se crea un contrato nuevo
  function getNum(address _myAddress) public view returns (uint);// no tiene llaves ni nada
}


// PARA USARLO 

contract MyContract {
  address NumberInterfaceAddress = 0xab38... 
  // ^ The address of the FavoriteNumber contract on Ethereum
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
  // Now `numberContract` is pointing to the other contract

  function someFunction() public {
    // Now we can call `getNum` from that contract:
    uint num = numberContract.getNum(msg.sender);
    // ...and do something with `num` here
  }
  
}

>In this way, your contract can interact with any other contract on the Ethereum blockchain, as long they expose those functions as public or external.
