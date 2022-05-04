// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;// ^el simbolo nos dice que los ultimos numeros son lo que pueden cambiar los demas no

contract Base{

uint256 public var1 = 100; // variables de estado 
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

function example() public   {
    
    var1 + var1;
}

  function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

function test(uint var4) public pure returns(uint256)
{ uint256 var5=0;
    var5 = var4 + var4;
    return var5;
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
Las funciones en REMIX en azul no modifican nada
Las Funcioenes en REMIX en naranja si modifica las variables de estado
*/
NOTAS sobre pure 

Solidity also contains pure functions, which means you're not even accessing any data in the app. Consider the following:

function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}

This function doesn't even read from the state of the app — its return value depends only on its function parameters. So in this case we would declare the function 
as pure.

INTERNAL

internal is the default visibility for state variables. Internal functions and state variables can both be accessed from within the same contract and in deriving

https://blog.oliverjumpertz.dev/solidity-visibility-modifiers
contracts. They aren't accessible from the outside.

EXTERNAL

external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.
We'll talk about why you might want to use external vs public later.

----------------UNA explliacacion mas----------------------


Tipos de Visibilidad:
 •Public: Totalmente accesible, sea cual sea el origen.
 ·External: Accesible desde una cuenta de propiedad externayatravés de
  un mensaje (llamada desde otro contrato). No es accesible desde una
 función del mismo contratoouno derivado del mismo.
 •Internal: Accesible únicamenteatravés de otra función incluida en el
  mismo contrato,odesde una función de un contrato que deriva del
  mismo. NO es accesible desde un mensaje de un contrato externoouna
  transacción externa.
  Private: Accesible únicamenteatravés de una función incluida en el
  mismo contrato.
Entre "public"y"external" en muchos casos es preferible usar "external", si la
lógica de negocio lo permite. Ya que éste modificador de visibilidad consume
menos gas.
