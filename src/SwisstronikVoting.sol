// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;
import {ISwisstronikVoting} from "./ISwisstronikVoting.sol";


contract SwisstronikVoting is ISwisstronikVoting {
    struct Candidate{
        uint id;
        uint voteCount;
        address Addr;
    }
    address private owner;
    address private winner;
    uint private votingCount;
    uint private votingStart;
    uint private votingDuration;
    Candidate [] private candidates;
    

    error zeroCandidate();
    error inValidAddress();
    error notOwner(address a);
    error votingNotEnded(uint _now);
    error invalidCandidateID (uint maxID);
    error votingClosed(uint _votingcloseTime);
    error notEligibleVoter(address fakeVoter);
    error winnerAlreadydeclared(address _winner);
    

    mapping (address => bool) private validVoter; //a map of valid and registered Voters

    modifier onlyOwner {
        if (msg.sender != owner ) revert notOwner(msg.sender);
        _;
    }

    modifier BeforeVotingEnds {
        (bool endded, uint _noww) = checkVotingEnded();
        if (endded) revert votingClosed(_noww);
        _;
    }
    /**
    @param _noOfCandidates is number of candidates participating in the election
    @param _voteDuration is duration of time the voting period lasts.
    @param candidates_addr is an array of contesting candidates
    This contract is expected to be deployed by the intended owner. Hence owner is deployer automatically
     */
    constructor(uint _noOfCandidates, uint _voteDuration, address [] memory candidates_addr)  {
        if (_noOfCandidates == 0) revert zeroCandidate();
        require(candidates_addr.length == _noOfCandidates, "invalid arrayLength");
        require(_voteDuration >= 1 days, "duration too short");
        // setup Candidates
        for(uint256 i = 0; i < _noOfCandidates; i++) {
            require(candidates_addr[i] != address(0), "address(0) candidate");
            candidates.push(Candidate({
                id: i,
                voteCount: 0,
                Addr: candidates_addr[i]
                
            }));
            
        }
    
        owner = msg.sender;
        votingStart = block.timestamp;
        votingDuration = _voteDuration;
        
    }

          //===============================//
         //      Voting Functions         //
        //===============================//

    /*
    @param _voters is array of voters to be registered
    modifier onlyOwner restricts function calling to owner only
    @BeforeVotingEnds ensures this function is only called within voting time
    
     */
    function registerNewVoters(address [] calldata _voters) onlyOwner BeforeVotingEnds external  returns(bool) {
        // ensures no address(0) is registered
        for (uint i; i < _voters.length; i ++){
            address cacheAddress = _voters[i];// caching the address
            if (cacheAddress != address(0)) {
                validVoter[cacheAddress] = true;
            }
        }
        return true;
    }

    /**
    @param _newOwner is address of a new owner incase `owner wants to transfer ownership`
     */

    function transferOwnership(address _newOwner) onlyOwner external returns(bool) {
        // reverts on zero address; Address(0) cant be owner( will get contract locked)
        if (_newOwner == address(0) ) revert inValidAddress();
        address cacheOld = owner;
        if (cacheOld == _newOwner ) revert inValidAddress();
        owner = _newOwner;
        return true;
    }

    /**
    @param _candidatesIndexOrId is Index/Id of candidate to be voted for.
    modifier BeforeVotingEnds ednsures function is called within voting timeFrame
     */
    function vote(uint8 _candidatesIndexOrId)  public BeforeVotingEnds returns(bool voted) {
        if (! validVoter[msg.sender]) revert notEligibleVoter(msg.sender);
        if (_candidatesIndexOrId >= candidates.length) revert invalidCandidateID(getCandidatesMaxIndex());
        // can only vote once
        validVoter[msg.sender] = false;
        // Effect Vote
        votingCount++;
        candidates[_candidatesIndexOrId].voteCount++;
        // disenfranchise voter after voting (This is a security measure to avoid inflation)
        voted = !validVoter[msg.sender];
    }

    // Function sets winner of election to state viarable `winner`
    // function can only be called after voting ends.
    function setWinner() onlyOwner public returns(address) {
        (bool endded, uint _noww) = checkVotingEnded();
        if (! endded) revert votingNotEnded(_noww);
        if (winner != address(0)) revert winnerAlreadydeclared(winner);
        address __winner = candidates[0].Addr;
        for(uint i = 1; i < getCandidatesMaxIndex() + 1; i++) {
            if (candidates[i].voteCount > candidates[i - 1].voteCount) {
                __winner = candidates[i].Addr;
            }
        }
        winner = __winner;
        return winner;
        

    }

      //===============================//
     //      View Functions           //
    //===============================//

    //returns contract Owner
    function oowner() public view returns(address) {
        return owner;
    }
    // returns the winner. If address(0), then voting is still on and not concluded.
    function getWinner() public view returns(address) {
        return winner;
    }

    /**
     _votingStart is time voting started (uinx time)
     _votingEnds is time voting ends (uinx time). If 0, voting has not ended
     */
    function getVotingStatus() public view returns (uint _votingStart, uint _votingEnds) {
        _votingStart = votingStart;
        _votingEnds = votingStart + votingDuration;
    }

    
    //returns the max Index of candidates. Which is total number - 1
    function getCandidatesMaxIndex() public view returns(uint maxIndex) {
        maxIndex =  candidates.length - 1;
    }
    // A private function to check if voting has ended
    function checkVotingEnded() private view returns(bool ended, uint _now) {
        uint timeVotingEnded = votingStart + votingDuration;
        if( timeVotingEnded < block.timestamp) {
            ended = true;
            _now = block.timestamp;
        }
    }
    function retrieveAllVoteCount() public view returns(uint) {
        return votingCount;
    }

}