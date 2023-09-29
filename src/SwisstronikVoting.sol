// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;
import {ISwisstronikVoting} from "../ISwisstronikVoting.sol";



contract SwisstronikVoting is ISwisstronikVoting {
    struct Candidate{
    uint id;
    uint voteCount;
}
    address private owner;
    address private winner;
    Candidate [] private candidates;

    error notOwner(address a);
    error inValidAddress();

    mapping (address => bool) private validVoter;

    modifier onlyOwner {
        if (msg.sender != owner ) revert notOwner(msg.sender);
        _;
    }
    constructor(uint _noOfCandidates)  {
        // setup Candidates
        for(uint256 i = 0; i < _noOfCandidates; i++) {
            
            candidates.push(Candidate({
                id: i,
                voteCount: 0
            }));
            
        }
        // This contract is expected to be deployed by the intended owner
        owner = msg.sender;
        
    }

    function registerNewVoters(address [] calldata _voters) onlyOwner external view returns(bool) {
        // ensures no address(0) is registered
        // 
    }

    function transferOwnership(address _newOwner) onlyOwner external returns(bool) {
        // reverts on zero address; Address(0) cant be owner( will get contract locked)
        if (_newOwner == address(0) ) revert inValidAddress();
        address cacheOld = owner;
        if (cacheOld == _newOwner ) revert inValidAddress();
        owner = _newOwner;
        return true;
    }

    // 
    function vote() public returns(bool) {}
    function setWinner() public returns(address) {}

      //===============================//
     //      View Functions           //
    //===============================//
    function oowner() public view returns(address) {
        return owner;
    }
    function getWinner() public view returns(address) {
        return winner;
    }



}