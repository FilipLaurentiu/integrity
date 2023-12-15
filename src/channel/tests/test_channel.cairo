use cairo_verifier::channel::channel::ChannelTrait;

#[test]
#[available_gas(9999999999)]
fn test_random_felts_to_prover() {
    let mut channel = ChannelTrait::new(
        u256 { low: 0xf7685ebd40e852b164633a4acbd3244c, high: 0xe8e77626586f73b955364c7b4bbf0bb7 }
    );
    let random = channel.random_felts_to_prover(3);
    assert(
        *random[0] == 3199910790894706855027093840383592257502485581126271436027309705477370004002,
        'invalid random felts[0]'
    );
    assert(
        *random[1] == 2678311171676075552444787698918310126938416157877134200897080931937186268438,
        'invalid random felts[1]'
    );
    assert(
        *random[2] == 2409925148191156067407217062797240658947927224212800962983204460004996362724,
        'invalid random felts[2]'
    );
}

#[test]
#[available_gas(9999999999)]
fn test_random_uint256_to_prover() {
    let mut channel = ChannelTrait::new(0);
    let random = channel.random_uint256_to_prover();
    assert(
        random == 0xae09db7cd54f42b490ef09b6bc541af688e4959bb8c53f359a6f56e38ab454a3,
        'invalid random uint256'
    );
}