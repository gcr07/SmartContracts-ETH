pragma solidity ^0.4.25;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); //Creacion de un evento para comunicarse con el frontend

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;// la manera de obtener el index esto me queda duda revisar
        emit NewZombie(id, _name, _dna); // Emite un evento es como los del socket estudialo!
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));// La manera de obtener un hash keccak256
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
