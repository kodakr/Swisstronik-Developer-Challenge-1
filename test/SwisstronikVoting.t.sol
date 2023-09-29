// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ISwisstronikVoting, SwisstronikVoting} from "../src/SwisstronikVoting.sol";

contract SwisstronikVotingTest is Test {
    SwisstronikVoting public voting;

    function setUp() public {
        // assumes msg.sender is owner (ie address(this))
        voting = new SwisstronikVoting(4);
    }

    function testOwner() public {
        assertTrue (voting.oowner() == address(this));
    }

}
