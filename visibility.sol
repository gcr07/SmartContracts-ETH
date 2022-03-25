
// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;// ^el simbolo nos dice que los ultimos numeros son lo que pueden cambiar los demas no

contract Base{

uint256 public var1 = 100;
uint256 private var2 =200;

function opera() private{
    var2 = var2 +1;
}

function increment() public  {
opera();
}

function getVal() public view returns(uint256){
    return var2;
}

}

// pure VS view ( NO Hacen transacciones)

//pure se usa cuando el contrato va a hacer algun tipo de matematica( segun el curso)
// view se usa cuando la funcion solo va a leer datos.

// https://solidity-by-example.org/visibility/

/* Internal − Internal functions/ Variables can only be used
 internally or by derived contracts. private
  Private functions/ Variables can only be used internally
    and not even by derived contracts.

*/
