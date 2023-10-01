// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "../src/SwisstronikVoting.sol";

contract SwisstronikVotingScript is Script {
    uint noOfCandidates = 4;
    address [] cadidatesArray = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
                                0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
                                0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
                                0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    ];
    function setUp() public {

    }
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SwisstronikVoting voting = new SwisstronikVoting(noOfCandidates, 2 days, cadidatesArray );
        vm.endBroadcast();
        
    }
}