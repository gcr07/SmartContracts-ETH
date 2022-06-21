// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.6;

contract Mod {
    uint256 public number = 5;


    function doMod(uint256 modValue) public view returns(uint256) {
        return 22 % modValue;
        // divide ente el numero y regresa el remainder(resto)
        // recuerda 10  entre 2.5 
        // seria 10 pones la casita (entre) 2.5
        // Usalo para numeros mas chicos que 5
    }

}
