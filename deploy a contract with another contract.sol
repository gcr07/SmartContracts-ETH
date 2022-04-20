// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol"; 

contract StorageFactory is SimpleStorage {
    
    SimpleStorage[] public simpleStorageArray;//para guardar las direcciones de cada contrato creado
    
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage(); // Sirve para crear un contrato regresa una direccion ( mas vien lo despliega)
        simpleStorageArray.push(simpleStorage); //Agrega una direccion al arreglo sucesivamente
    }
    
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public { // PAra interactuar con un contrato necesitamos 2 cosas su direccion y su ABI
        // Address 
        // ABI 
        //this line has an explicit cast to the address type and initializes a new SimpleStorage object from the address
        // Para que le entendamos mejor vamos a escribirlo todo 
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber); // Interactuar con otros contratos from other contracts 
        //SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber); 

        //this line simply gets the SimpleStorage object at the index _simpleStorageIndex in the array simpleStorageArray
        //simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        //this line has an explicit cast to the address type and initializes a new SimpleStorage object from the address 
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve(); 

        //this line simply gets the SimpleStorage object at the index _simpleStorageIndex in the array simpleStorageArray
        //return simpleStorageArray[_simpleStorageIndex].retrieve(); 
    }
}
