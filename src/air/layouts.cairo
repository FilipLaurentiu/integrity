// === DEX BEGIN ===
// mod dex;
// === DEX END ===
// === RECURSIVE BEGIN ===
mod recursive;
// === RECURSIVE END ===
// === RECURSIVE_WITH_POSEIDON BEGIN ===
// mod recursive_with_poseidon;
// === RECURSIVE_WITH_POSEIDON END ===
// === SMALL BEGIN ===
// mod small;
// === SMALL END ===
// === STARKNET BEGIN ===
// mod starknet;
// === STARKNET END ===
// === STARKNET_WITH_KECCAK BEGIN ===
// mod starknet_with_keccak;
// === STARKNET_WITH_KECCAK END ===

use cairo_verifier::{
    air::{
        public_input::PublicInput,
        traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness, TracesConfig},
    },
    channel::channel::Channel,
};


trait LayoutTrait<InteractionElements, impl InteractionElementsDrop: Drop<InteractionElements>> {
    fn eval_composition_polynomial(
        interaction_elements: InteractionElements,
        public_input: @PublicInput,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_domain_size: felt252,
        trace_generator: felt252
    ) -> felt252;

    fn eval_oods_polynomial(
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;

    fn traces_commit(
        ref channel: Channel,
        unsent_commitment: TracesUnsentCommitment,
        config: TracesConfig
    ) -> TracesCommitment<InteractionElements, InteractionElementsDrop>;

    fn traces_decommit(
        queries: Span<felt252>,
        commitment: TracesCommitment<InteractionElements, InteractionElementsDrop>,
        decommitment: TracesDecommitment,
        witness: TracesWitness,
    );

    fn verify_cairo0(self: @PublicInput) -> (felt252, felt252);

    fn verify_cairo1(self: @PublicInput) -> (felt252, felt252);
}