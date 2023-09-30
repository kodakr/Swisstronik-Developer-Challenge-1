// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;


interface ISwisstronikVoting {
    function registerNewVoters(address [] calldata _voters) external returns(bool);
    function vote(uint8 _candidatesIndexOrId)  external returns(bool voted);
    function transferOwnership( address _newOwner) external returns(bool);
    function setWinner()  external returns(address);
    function oowner() external view returns(address);
    function getWinner() external view returns(address);
    function getVotingStatus() external view returns (uint _votingStart, uint _votingEnds);
    function getCandidatesMaxIndex() external view returns(uint maxIndex);
     




}