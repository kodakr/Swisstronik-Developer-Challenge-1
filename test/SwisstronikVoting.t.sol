// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ISwisstronikVoting, SwisstronikVoting} from "../src/SwisstronikVoting.sol";

contract SwisstronikVotingTest is Test {
    SwisstronikVoting public voting;
    address hacker;

    function setUp() public {
        // assumes msg.sender is owner (ie address(this))
        voting = new SwisstronikVoting(4);
        hacker = makeAddr("hacker");
    }

    function testOwner() public {
        assertTrue (voting.oowner() == address(this));
    }
    function testNonOwnercantRegister() public {
        address [] memory _voters = new address [] (2);
        _voters[0] = hacker;
        vm.expectRevert();
        vm.prank(hacker);
        voting.registerNewVoters(_voters);
    }

}
