pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "./AvObjects.sol";
import "./AvEvents.sol";


// shared storage
contract AvStorage is AvObjects, AvEvents, Ownable {

    mapping (uint => ExampleObject) examples;

}

