// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;

contract Doge {
  function catchphrase() public view virtual returns (string memory) { // Se hace virtual para que al heredarse su comportamiento sea diferente
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function catchphrase() public view virtual override  returns (string memory) { // Mismo nombre pero al usar override se comporta diferente
    return "Such Moon BabyDoge";
  }
}
