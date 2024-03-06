use cairo_verifier::{
    channel::channel::{Channel, ChannelTrait},
    table_commitment::table_commitment::{table_commit, TableCommitment, TableCommitmentConfig},
    vector_commitment::vector_commitment::{VectorCommitment, VectorCommitmentConfig},
};

// === BLAKE ONLY BEGIN ===
// #[test]
// #[available_gas(9999999999)]
// fn test_table_commit_0() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
//     //
//     let config = TableCommitmentConfig {
//         n_columns: 0x8,
//         vector: VectorCommitmentConfig {
//             height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
//         },
//     };
// 
//     let unsent_commitment: felt252 =
//         0x821aaa485d3fbdf7b0a06d773e565370f794c06bbcb4e23279a39544782c1e;
// 
//     let vector_commitment = VectorCommitment {
//         config: VectorCommitmentConfig {
//             height: 0xf, n_verifier_friendly_commitment_layers: 0x16,
//         },
//         commitment_hash: unsent_commitment
//     };
// 
//     assert(
//         table_commit(
//             ref channel, unsent_commitment, config
//         ) == TableCommitment { config: config, vector_commitment: vector_commitment },
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// 
// #[test]
// #[available_gas(9999999999)]
// fn test_table_commit_1() {
//     let mut channel = ChannelTrait::new_with_counter(0x0, 0x0);
// 
//     let config = TableCommitmentConfig {
//         n_columns: 0x4,
//         vector: VectorCommitmentConfig {
//             height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
//         },
//     };
// 
//     let unsent_commitment: felt252 =
//         0x7a73129c87d8a60cb07b26775437ac75790bbd415d47912e5eb1f7c7e11d42f;
// 
//     let vector_commitment = VectorCommitment {
//         config: VectorCommitmentConfig {
//             height: 0xd, n_verifier_friendly_commitment_layers: 0x16,
//         },
//         commitment_hash: unsent_commitment
//     };
// 
//     assert(
//         table_commit(
//             ref channel, unsent_commitment, config
//         ) == TableCommitment { config: config, vector_commitment: vector_commitment },
//         'Invalid value'
//     );
// 
//     assert(channel.digest == 0x0, 'Invalid value');
//     assert(channel.counter == 0x0, 'Invalid value');
// }
// === BLAKE ONLY END ===

// === KECCAK ONLY BEGIN ===
#[test]
#[available_gas(9999999999)]
fn test_table_commitment_commit() {
    let mut channel = ChannelTrait::new_with_counter(
        0x1b9182dce9dc1169fcd00c1f8c0b6acd6baad99ce578370ead5ca230b8fb8c6, 0x1
    );

    let unsent_commitment = 0x1e9b0fa29ebe52b9c9a43a1d44e555ce42da3199370134d758735bfe9f40269;

    let config = TableCommitmentConfig {
        n_columns: 0x4,
        vector: VectorCommitmentConfig { height: 0x9, n_verifier_friendly_commitment_layers: 0x64, }
    };

    assert(
        table_commit(
            ref channel, unsent_commitment, config
        ) == TableCommitment {
            config: config,
            vector_commitment: VectorCommitment {
                config: config.vector, commitment_hash: unsent_commitment
            },
        },
        'Invalid value'
    );

    assert(
        channel.digest == 0x1abd607dab09dede570ed131d9df0a1997e33735b11933c45dc84353df84259,
        'Invalid value'
    );
    assert(channel.counter == 0x0, 'Invalid value');
}
// === KECCAK ONLY END ===


