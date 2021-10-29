
// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;// ^el simbolo nos dice que los ultimos numeros son lo que pueden cambiar los demas no

contract Test1{ // nO IMPORTA QUE SE LLAME DE OTRA MANERA AL ARCHIVO
    
    uint256 count;

   constructor(uint256 _count){
     // function nombredelcontrato esto es para versiones viejas
     count = _count;
 }


function setCount(uint256 _count)public{// que para poder ser accedido desde afuera
    count= _count;
}

function incrementCount() public{
 
 count += 1;
    
}
 
function getCount() public view returns(uint256){// view para que decirle que no a a cambiar nada returns por ser una funcion geter
// para saber que va a ser regresado no consume gas
    return count;
} 



function getNumber()public pure returns(uint256) {// el pure es la mas restrictiva ni si quiera va a leer
    //pure no consume gas 
    return 34;
}
 
 
}
