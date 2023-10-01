// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "../src/SwisstronikVoting.sol";
import "forge-std/console.sol";

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
        vm.stopBroadcast();
        console.log("addr=====", address(voting));
        
    }
}
// 52762ab3569e55fca22b1e1c0bb9a5514968d9aebd743fadd13fd4c57674633b
// https://json-rpc.testnet.swisstronik.com
// https://ethereum-goerli.publicnode.com
// https://goerli.infura.io/v3/3d05647a39544dafab60d295c1ece741
// forge script script/SwisstronikVoting.s.sol:SwisstronikVotingScript --rpc-url $SWISSTRONIC_TEST_RPC_URL --broadcast --verify -vvvv

/**

forge verify-contract \
    --chain-id 5 \
    --num-of-optimizations 1000000 \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,uint256,address[])" 4 172800 [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB]) \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --compiler-version v0.8.21+commit.d9974bed \
    0x06d70420e15fA9671016c7998C56dD36d1Ec94eD \
    src/SwisstronikVoting.sol:SwisstronikVoting 

Submitted contract for verification:
                Response: `OK`
                GUID: `a6yrbjp5prvakia6bqp5qdacczyfhkyi5j1r6qbds1js41ak1a`
                url: https://sepolia.etherscan.io//address/0x6a54…3a4c#code








 */
// [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB]

