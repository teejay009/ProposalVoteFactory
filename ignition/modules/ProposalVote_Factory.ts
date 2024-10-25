import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ProposalVote_FactoryModule = buildModule("ProposalVote_FactoryModule", (m) => {
  const proposalVoteFactory = m.contract("ProposalVoteFactory");

  


  return { proposalVoteFactory };
});

export default ProposalVote_FactoryModule;