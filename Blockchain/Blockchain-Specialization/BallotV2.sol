pragma solidity ^0.4.0;

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
    }

    struct Proposal {
        uint voteCount;
    }

    enum Stage {Init, Reg, Vote, Done}
    Stage public stage = Stage.Init;
    uint startTime;

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    function Ballot (uint8 _numProposals) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        proposals.length = _numProposals;
        stage = Stage.Reg;
        startTime = now;
    }

    function register (address toVoter) public {
        if(stage != Stage.Reg || msg.sender != chairperson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
        if(now > (startTime + 10 seconds)) {
            stage = Stage.Vote;
            startTime = now;
        }
    }

    function vote (uint8 toProposal) public {
        if(stage != Stage.Vote) return;
        Voter storage sender = voters[msg.sender];
        if(sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
        if(now > (startTime + 10 seconds)) stage = Stage.Done;
    }

    function winningProposal() public constant returns (uint8 _winningProposal) {
        if(stage != Stage.Done) return;
        uint256 winningVoteCount = 0;
        for(uint8 prop = 0; prop < proposals.length; prop++) {
            if(proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
    }
}