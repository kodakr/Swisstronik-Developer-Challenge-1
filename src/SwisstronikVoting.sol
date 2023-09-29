// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;

interface ISwisstronikVoting {
    function registerNewVoters(address [] calldata _voters) external view returns(bool);
    //function vote() external returns(bool);
    //function transferOwnership( address _newOwner) external returns(bool);
}

contract SwisstronikVoting is ISwisstronikVoting {
    address private owner;
    error notOwner(address a);

    mapping (address => bool) private validVoter;

    modifier onlyOwner {
        if (msg.sender != owner ) revert notOwner(msg.sender);
        _;

    }
    constructor() {
        // This contract is expected to be deployed by the intended owner
        // transfer of ownership???
        owner = msg.sender;
    }

    function registerNewVoters(address [] calldata _voters) onlyOwner external view returns(bool) {
        // ensures no address(0) is registered
        // 
    }

    function transferOwnership(address _newOwner) onlyOwner external returns(bool) {
        // reverts on zero address;
        address cacheOld = owner;
        owner
    }



}