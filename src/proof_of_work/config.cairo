const MIN_PROOF_OF_WORK_BITS: u256 = 30;
const MAX_PROOF_OF_WORK_BITS: u256 = 50;
const BYTE_UPPER_BOUND: u32 = 256; // 2 ** 8
const WORD_UPPER_BOUND: u128 = 18446744073709551616; // 2 ** 64

#[derive(Drop, Copy)]
struct ProofOfWorkConfig {
    // Proof of work difficulty (number of bits required to be 0).
    n_bits: u8,
}

fn proof_of_work_config_validate(config: ProofOfWorkConfig) {
    assert(config.n_bits.into() >= MIN_PROOF_OF_WORK_BITS, 'value proof of work bits to low');
    assert(config.n_bits.into() <= MIN_PROOF_OF_WORK_BITS, 'value proof of work bits to big');
}
