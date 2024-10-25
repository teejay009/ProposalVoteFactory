// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./ProposalVote.sol";

contract ProposalVoteFactory {
    ProposalVote[] public proposalVotes;

    mapping(address => ProposalVote[]) public userProposals;

    event ProposalVoteDeployed(
        address indexed contractAddress,
        address indexed creator
    );

    // create a new ProposalVote contract instance
    function createProposalVote() external {
        ProposalVote newProposalVote = new ProposalVote();

        proposalVotes.push(newProposalVote);

        userProposals[msg.sender].push(newProposalVote);

        emit ProposalVoteDeployed(address(newProposalVote), msg.sender);
    }

    function getAllProposalVotes()
        external
        view
        returns (ProposalVote[] memory)
    {
        return proposalVotes;
    }

    function getUserProposals(
        address _user
    ) external view returns (ProposalVote[] memory) {
        return userProposals[_user];
    }

    function createProposal(
        uint256 _index,
        string memory _title,
        string memory _desc,
        uint16 _quorum
    ) external {
        require(
            _index < proposalVotes.length, "ProposalVote instance does not exist"
        );

        ProposalVote proposalVote = proposalVotes[_index];
        proposalVote.createProposal(_title, _desc, _quorum);
    }

    
    function voteOnProposal(
        uint256 _contractIndex,
        uint8 _proposalIndex
    ) external {
        require(
            _contractIndex < proposalVotes.length,
            "ProposalVote instance does not exist"
        );

        ProposalVote proposalVote = proposalVotes[_contractIndex];
        proposalVote.voteOnProposal(_proposalIndex);
    }


    function getProposal(
        uint256 _contractIndex,
        uint8 _proposalIndex
    )
        external
        view
        returns (
            string memory title_,
            string memory desc_,
            uint16 voteCount_,
            address[] memory voters_,
            uint16 quorum_,
            ProposalVote.PropsStatus status_
        )
    {
        require(
            _contractIndex < proposalVotes.length,
            "ProposalVote instance does not exist"
        );

        ProposalVote proposalVote = proposalVotes[_contractIndex];
        return proposalVote.getProposal(_proposalIndex);
    }
}