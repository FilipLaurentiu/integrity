use cairo_verifier::{
    air::{
        traces::{TracesUnsentCommitment, TracesCommitment, TracesDecommitment, TracesWitness, TracesConfig},
        layouts::recursive::{
            constants::{NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND}, global_values::InteractionElements,
        },
    },
    channel::channel::{Channel, ChannelTrait},
    table_commitment::table_commitment::{
        table_commit, table_decommit,
    },
    vector_commitment::vector_commitment::VectorCommitmentConfigTrait,
};


const MAX_N_COLUMNS: felt252 = 128;

// Reads the traces commitment from the channel.
// Returns the commitment, along with GlobalValue required to evaluate the constraint polynomial.
fn traces_commit(
    ref channel: Channel, unsent_commitment: TracesUnsentCommitment, config: TracesConfig
) -> TracesCommitment<InteractionElements> {
    // Read original commitment.
    let original_commitment = table_commit(
        ref channel, unsent_commitment.original, config.original
    );
    // Generate interaction elements for the first interaction.
    let interaction_elements = InteractionElements {
        memory_multi_column_perm_perm_interaction_elm: channel.random_felt_to_prover(),
        memory_multi_column_perm_hash_interaction_elm0: channel.random_felt_to_prover(),
        range_check16_perm_interaction_elm: channel.random_felt_to_prover(),
        diluted_check_permutation_interaction_elm: channel.random_felt_to_prover(),
        diluted_check_interaction_z: channel.random_felt_to_prover(),
        diluted_check_interaction_alpha: channel.random_felt_to_prover(),
    };
    // Read interaction commitment.
    let interaction_commitment = table_commit(
        ref channel, unsent_commitment.interaction, config.interaction
    );

    TracesCommitment {
        original: original_commitment,
        interaction_elements: interaction_elements,
        interaction: interaction_commitment,
    }
}

// Verifies a decommitment for the traces at the query indices.
// decommitment - holds the commited values of the leaves at the query_indices.
fn traces_decommit(
    queries: Span<felt252>,
    commitment: TracesCommitment<InteractionElements>,
    decommitment: TracesDecommitment,
    witness: TracesWitness,
) {
    table_decommit(commitment.original, queries, decommitment.original, witness.original);
    table_decommit(commitment.interaction, queries, decommitment.interaction, witness.interaction)
}
