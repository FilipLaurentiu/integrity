use cairo_verifier::{StarkProof, CairoVersion};
use starknet::ContractAddress;

#[starknet::interface]
trait ICairoVerifier<TContractState> {
    fn verify_proof(
        ref self: TContractState, stark_proof: StarkProof, cairo_version: CairoVersion, contract_address_1: ContractAddress, contract_address_2: ContractAddress
    ) -> (felt252, felt252);
}

#[starknet::component]
mod CairoVerifier {
    use cairo_verifier::{CairoVersion, PublicInputImpl, stark::{StarkProof, StarkProofImpl}};
    use starknet::ContractAddress;

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProofVerified: ProofVerified,
    }

    #[derive(Drop, starknet::Event)]
    struct ProofVerified {
        #[key]
        program_hash: felt252,
        #[key]
        output_hash: felt252,
    }

    const SECURITY_BITS: felt252 = 50;

    impl CairoVerifierImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ICairoVerifier<ComponentState<TContractState>> {
        fn verify_proof(
            ref self: ComponentState<TContractState>,
            stark_proof: StarkProof,
            cairo_version: CairoVersion,
            contract_address_1: ContractAddress,
            contract_address_2: ContractAddress
        ) -> (felt252, felt252) {
            stark_proof.verify(SECURITY_BITS, contract_address_1, contract_address_2);
            let (program_hash, output_hash) = match cairo_version {
                CairoVersion::Cairo0 => stark_proof.public_input.verify_cairo0(),
                CairoVersion::Cairo1 => stark_proof.public_input.verify_cairo1(),
            };
            self.emit(ProofVerified { program_hash, output_hash });
            (program_hash, output_hash)
        }
    }
}
