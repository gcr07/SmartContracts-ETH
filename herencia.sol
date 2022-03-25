

//Single Inheritance

// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;// ^el simbolo nos dice que los ultimos numeros son lo que pueden cambiar los demas no

contract Base{

uint256 var1 = 100; // variables de estado.

function getVal() public view returns(uint256){
return var1;

}

}

contract Child is Base{

function increment() public
{
var1 = var1 +1 ;
}


}


/*
 El contrato del que otros contratos heredan características se conoce como contrato base, 
 mientras que el contrato que hereda las características se denomina contrato derivado.
*/
