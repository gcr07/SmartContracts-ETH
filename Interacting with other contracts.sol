
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


contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);// no tiene llaves ni nada
}
