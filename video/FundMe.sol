// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract FundMe {


    mapping(address => uint) public addressToAmountFunded;

    function fund() public payable{
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
        
    }

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        
      (,int256 answer,,,)=priceFeed.latestRoundData();
    return uint256(answer * 10000000000);
    }
    //como sabemos que regresa 
    //un numero de 8 cifras y para expresarlo
    //en wei tienene que ser 18 ceros
     
    function getConversionRate(uint256 ethAmount)public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 10000000000;
        return ethAmountInUsd;
    }


}
