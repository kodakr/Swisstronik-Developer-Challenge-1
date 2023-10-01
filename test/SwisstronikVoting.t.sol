// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ISwisstronikVoting, SwisstronikVoting} from "../src/SwisstronikVoting.sol";
//import {Console} from 
import "forge-std/console.sol";

contract SwisstronikVotingTest is Test {
    SwisstronikVoting public voting;
    ISwisstronikVoting public Ivoting;
    address hacker = makeAddr("hacker");
    address voter1 = makeAddr("voter1");
    address voter2 = makeAddr("voter2");
    address voter3 = makeAddr("voter3");
    address voter4 = makeAddr("voter4");
    address voter5 = makeAddr("voter5");
    address nonVoter1 = makeAddr("nonVoter1");
    uint public noOfCandidates = 4;
    address cand1 = makeAddr("cand1");
    address cand2 = makeAddr("cand2");
    address cand3 = makeAddr("cand3");
    address cand4 = makeAddr("cand4");
    address [] cadidatesArray; //= new address [] (noOfCandidates);
    address [] registerVotersArray;
    bool registered;

    function setUp() public {
        generateCandidates();
        // assumes msg.sender is owner (ie address(this))
        voting = new SwisstronikVoting(noOfCandidates, 2 days, cadidatesArray );
        Ivoting = ISwisstronikVoting(address(voting));
        generatevotersArray();
        registered = Ivoting.registerNewVoters(registerVotersArray);

    }
    function generateCandidates() private {
        cadidatesArray.push(cand1);
        cadidatesArray.push(cand2);
        cadidatesArray.push(cand3);
        cadidatesArray.push(cand4);
        
    }
    function generatevotersArray() private {
        registerVotersArray.push(voter1);
        registerVotersArray.push(voter2);
        registerVotersArray.push(voter3);
        registerVotersArray.push(voter4);    
        registerVotersArray.push(voter5);
    }

    function testOwner() public {
        assertTrue (voting.oowner() == address(this));
    }
    function testNonOwnercantRegister() public {
        address [] memory _voters = new address [] (2);
        _voters[0] = hacker;
        vm.expectRevert();
        vm.prank(hacker);
        Ivoting.registerNewVoters(_voters);
    }
    function testEntireWorkFlowandOutputsOwner() public {
        vm.prank(voter1);
        Ivoting.vote(0);
        vm.prank(voter2);
        Ivoting.vote(2);
        vm.prank(voter3);
        Ivoting.vote(1);
        vm.prank(voter4);
        Ivoting.vote(1);
        vm.prank(voter5);
        Ivoting.vote(3);
        vm.warp(block.timestamp + 3 days);
        address winner = Ivoting.setWinner();
        console.log("winner==", winner);
        uint c = Ivoting.retrieveAllVoteCount();
        console.log("_votingCounts",c);
        assertTrue(winner != address(0));
    }
    function testgetVotingStatus() public {
        (uint a, uint b) = Ivoting.getVotingStatus();
        console.log("_votingStart==",a);
        console.log("_votingEnds==",b);
        assertTrue(b > a);
    }


} 