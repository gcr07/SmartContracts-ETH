// SPDX-License-Identifier: MIT

pragma  solidity ^0.8.6;

contract Base
{

struct People 
{
uint256 favoriteNumber;
string name;

}
// index 0 2 index 1 Masa
People public person1 = People({favoriteNumber:2,name:"Masa"}); 
//Array dinamico

People[] public persons;
mapping(string => uint256) public nameToFavoriteNumber;

function addPerson( string memory _name, uint256 _favoriteNumber) public
{
    persons.push(People(_favoriteNumber, _name));
    nameToFavoriteNumber[_name] = _favoriteNumber;
}












/* Memory data will be only storage during the execution of the function or the contract call


Storage los datos va a persistir aun despues de que la funcion se ejecute.(EN OTRAS palabras store for ever)


*/
