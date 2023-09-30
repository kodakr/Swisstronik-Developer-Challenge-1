// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;


interface ISwisstronikVoting {
    function registerNewVoters(address [] calldata _voters) external returns(bool);
    //function vote() external returns(bool);
    //function transferOwnership( address _newOwner) external returns(bool);
}