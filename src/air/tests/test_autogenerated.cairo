use core::array::SpanTrait;
use core::array::ArrayTrait;
use cairo_verifier::{
    air::{
        autogenerated::{eval_composition_polynomial_inner, eval_oods_polynomial_inner},
        constants::{
            MASK_SIZE, N_CONSTRAINTS, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, CONSTRAINT_DEGREE
        },
        global_values::{GlobalValues, EcPoint},
    },
    tests::stone_proof_fibonacci,
};

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_eval_composition_polynomial_inner() {
    let oods_values = stone_proof_fibonacci::stark::oods_values::get();
    let mask_values = oods_values.span().slice(0, MASK_SIZE);
    let constraint_coefficients = stone_proof_fibonacci::constraint_coefficients::get()
        .span()
        .slice(0, N_CONSTRAINTS);
    let point = 0x47148421d376a8ca07af1e4c89890bf29c90272f63b16103646397d907281a8;
    let trace_generator = 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046;

    let global_values = GlobalValues {
        trace_length: 0x40000,
        initial_pc: 0x1,
        final_pc: 0x5,
        initial_ap: 0x25,
        final_ap: 0x68,
        initial_pedersen_addr: 0x6a,
        initial_range_check_addr: 0x1ea,
        initial_bitwise_addr: 0x9ea,
        range_check_min: 0x7ffa,
        range_check_max: 0x8001,
        offset_size: 0x10000,
        half_offset_size: 0x8000,
        pedersen_shift_point: EcPoint {
            x: 0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804,
            y: 0x3ca0cfe4b3bc6ddf346d49d06ea0ed34e621062c0e056c1d0405d266e10268a
        },
        pedersen_points_x: 0x3b99115c391c74e0a1c4d552c32130023843f519e0fd9517ac9ba01959591ae,
        pedersen_points_y: 0x3e3a5bebd5914636340491736919e1f9847ff4690da93ecbb68be51fa836434,
        memory_multi_column_perm_perm_interaction_elm: 0x4e0295d5d071e74058eef68f686aac70757fbe53d10971f6187a0e76ff440c1,
        memory_multi_column_perm_hash_interaction_elm0: 0x2f73db13acfcad0387e92ccd565128e7e2c24026015ed4c0ef8619a213019cc,
        range_check16_perm_interaction_elm: 0x7ea83ddd48c6068a1a11f3a107ada2da689636c6028061ff7fb8ef8f2a18bef,
        diluted_check_permutation_interaction_elm: 0x4bc33ab9e5b3855f07ad50717b923e4f8bea45737b6462fa60c27e32b315d95,
        diluted_check_interaction_z: 0x1c695cf20c4393e7ffe8d8c7efcce3797f0744aa575c58b99728a573ef96529,
        diluted_check_interaction_alpha: 0x163023769a9ccfc222f8cb9a71a4630d400cd89c34dc14718e907fadc66877f,
        memory_multi_column_perm_perm_public_memory_prod: 0x5c34f8a8720acf734afb0da2942cdfea1cc640f6021208fb11c2c508f8e8d49,
        range_check16_perm_public_memory_prod: 0x1,
        diluted_check_first_elm: 0x0,
        diluted_check_permutation_public_memory_prod: 0x1,
        diluted_check_final_cum_val: 0x78301d010d16217d6a9896f2641b4c0d9741996904cb2ca4919714055e6580f
    };

    assert(
        eval_composition_polynomial_inner(
            mask_values, constraint_coefficients, point, trace_generator, global_values,
        ) == 0x511668bf439c0999c57d3c05c9f1bcf12095ef76d5a032985bd2350f1731604,
        'Invalid value'
    )
}

// test data from cairo0-verifier run on stone-prover generated proof
#[test]
#[available_gas(9999999999)]
fn test_eval_oods_polynomial_inner() {
    let column_values = array![
        0x5900b3cc21a91beadc7d227c7ab4de9d8666bbe9cef8cd3b53c96227636baa7,
        0x364ec5a537535bfed197fa6d37ddc5059b46f7ddc3106e32c869c4af92801a4,
        0x3e0ee23636524e70df1d826df10120ba276b4045fa3cc21f68b80aca8a6bcf6,
        0x1615927ad08e7071d224fd62277c733856264b019f19348cc06d12c818347a1,
        0x139bc4a27e309456740143e4d681d0482789ec7e6464b4fe0d7ed276d87c241,
        0x6977d98591d84c22adecac4b4dc42a0b2e609c0daf993e538c9720521dbf02d,
        0xfa852d9525f19f876b72d275a75b63beb87c7f5934285378e8163804ad58aa,
        0x12c213443cac1d7138a5ecc07a4eca17719894b5503fe5f658186066951ec0b,
        0x6bf897a3f79da8666994fad140c1d7916c7e27c9836856ca160c1a49b28b408,
        0x5a4730e9f179e6bb22412d9a14eb5bfd8c8e5197b0fc0a962a94eb2d8542ea3,
        0x2187d700f2a286da191941824f267f4199e07cc1707b5b346868dcb718c30e5,
        0x497821407826448c240a13a2b2c2c15c47fbe074d29c2446a2bf63020483765
    ];

    let oods_values = stone_proof_fibonacci::stark::oods_values::get().span();

    let constraint_coefficients = array![
        0x1,
        0x2d0d0ad7f32fd0b0f5fe5c157feb7007baa104e9a151de3beb77548f0a9ad1b,
        0x7d5b06b7b2a583ac90151c3e9530b804195a337472eb61bc81b75763f4abdc2,
        0x39b16cc99c5833138a5795fdeb4335f2c07fb499ecbc1520e2bea1266d49d2b,
        0x4c1dae026b30cc8eb8dd4c0d5a28dcb8d028b2d961f2e32ea5f6503ca405658,
        0x5cbb13bde350753ccbae31fb271143de7edf97a36d4749f6bfafaaec14c8ef7,
        0x48862b8f3f49c82b6f39edf8f7e7e25d60c6be4c5daa68e9972f0dc3c894a2f,
        0x155b7253d4baa38b0d2c74013b12a928991857b4e265f1ac6eaa712be2d20c6,
        0x67ca5402d1b4eac70b6b480f1169cc84f333360bd219bf9939dc5d38a23befa,
        0x50adf03b2b141cfd70c5f47f6c29263235aafeb3c3aa9e8afc051345920a9b3,
        0x263508a912f59515af8638fcc82ff84a14bbdb4538cccdc31a0288015e6c634,
        0x7141789e40b93bd2dbdd20d8cd4582d862ecf5f368b1387f18829e437daacef,
        0x77b25dcdab55b1b7436af4e4127aa37da15cf60cfe6a3198ee95116f63ddc7e,
        0x1988e062e2e8c59172d130188cd856840ee7dc0002d828b9a3ef0f9bf953ec1,
        0x6e7ff202bb2aca006dd912016e395987c939e37c5bb55fe84e59733b0c05a9c,
        0x79417edf98fa2067c6a986a908fca70c84bcc21b05bc0996eb3badc6f3ac806,
        0x7fd7802edc7cda567a7afadf4318c46f8c3401bd4ac289c142cdcc5dcfb015f,
        0x7b59987b0b60021be0603b6da7bee08cee00cf4187e7a46c57e07c444a2f7a7,
        0x62d4e1f9b7398c0e3f21a47d4b7894397e6205f00632e09f58683f275a05a47,
        0x41afc0acdb24c4a21d90c9e1d26eae2add9bd4223b2f0701a279aef161e4afd,
        0x6eb3d355dad4d6b9de6bc6964a64d0360162dc138c2421cc8c5983d85fb9930,
        0x5885ff622c584616c77ea9cfe0d7be86260254f009446d692e6e2c95002e2e2,
        0x408c0f4f159fea0254fb6d0e5516d3c5ec0854fe53f420690dbb8bda3cecd9f,
        0x7bf330c278f640b40044cbc03b17dcb925d4bca9c4dd753bd36fa73fe64f2b6,
        0xb821e205c14731c116b7ba585f5ef14919291e56304d6131755c93487d57b5,
        0x63d6ac3daae6eb8c8a108d8837b1e1f9b814a6672129954d2c19d960b970de5,
        0x56984c83a9a2f0b0f0a10b30b3790080e1503563948365104c8ff140d2c78b2,
        0x6ace2bc8eacf3fb502cab0dbfaacb99ccdc7c5cab933878f0f00ecd4306167a,
        0x15bb3ff352e561599bd8b42ef46517cfd45ddfc7ab0032876d429a04c425850,
        0x72c94f8c4753f31f02a7674570c734e0006012fc4ec439ce9839aa120eaa4ae,
        0x23f2351b6785fca8e7cd4c2231f1c653f685e096887ce3002858c06db5ae808,
        0xc6f530c9000ce52aca56a6266f5bde037c75e84c9d5a0f1fa7577e4b276eba,
        0x275f5489f6629548d7d1e9dc42ee0d68ab862c0c6bc840b7184e832c28716b7,
        0x708f0a7598c158818da04add3a3a94ac9b35fba89532c567667db0b67922a68,
        0x2a68726aa6d0e52c705915d0829e3b20337df89bd80697393b9de609a122d54,
        0x5cfb1a0480bfdbacbf434d54660da1b4071a02616d22c778a045dfc773dc207,
        0x56d8a93ec7d6d9b50a915cf39a75122efacfe89025bf057008afe564d9432c7,
        0x73cecef8f88825b058d10ebae2523540fd0250cd9d9fd0d520371759041c235,
        0x3a50c3c98d7d713cdadbc0c0bf0f7e156e8681eeb420f9a239c8b30a417f2e9,
        0x5a97fe52d11862b3df7c9b46406271188350c5f5c319d19739b7479bc39af8c,
        0x36d28ec3f6dc71e00a182d088dc1ff94f443c009b52cf671a3e6e9b40cc1471,
        0x2be34062e9a0e3ee6b92db97f74e23407eddee1f2b059ef050f4c23d6d30f91,
        0x6e1de2b0e184458047f15e44f3925d27913044b3d59bc982256eaff7a37bf04,
        0x30b1757d533dbf540d7a6717bd1a76c95209e1094ff961884e3b51cc226572,
        0x6ce9f661ee14ed07929289fed6eb777d4c21ab540000b3ab1f23f5d4b4a5c32,
        0x74606ac3e2d9448c262b42fdc8a3888fadabb88d8cb66d295b1211afb37b15d,
        0x242875c8b7192ab13af8a3dcccae9f81dff3a9753af23a5842e46dc612e54d2,
        0x69c14cb8184227f54d42edf67877f47a9b920067c3764de79d2366906d98f2c,
        0x9e852fd35b869d9bd613ea2c52c90f959035035d98a562edba928c9ae155af,
        0x1c9fc0237527d822435a9012dd59d5bb4ad804d189ef43a5604e842c5fb5efa,
        0x34a22c8d4fc8027ee0eb68ab0cf135438fe1232d75d5c40d76fa66571bcbe8a,
        0x363f8f66f6b23362bf62e99503c3a6699ced2b3a41bd7976c82b6c1a663622c,
        0x4e7832f85f0f6113cbbe755b869264f997193d3b3152b384b8eb97fb268fc00,
        0x63d1e42fee3655ebbad44d80c61de04fe0bab96220d9aee7829606487e9ed1d,
        0x2cb09f415cafc5be40fe3618252e4d5810a7ab8a57f3854a100352717568e4a,
        0x20f1d7ac73dba474684361ec3a9a3838f565dd53716651245e7a9e2cbe23f50,
        0x396a68bde0b0b86a37a618a1ba1addcb07d77e24ac83af4c6fdd586e7d78903,
        0x2bde9a91089cd6df42a1cbf54e4f84a53ade71ad6184cc38730d326f5f5ec92,
        0x4e072eaf392e616a6850550a53ccac806ae217faa00d0ede040c36c7a554005,
        0x78ba441eeab39cfea8136e425a8a218fba0f46c6883cdc51dfb3b4743e5107a,
        0x74d2a90d7c4427adf6aa0a8b89719bca414d4308633013243b819eb9e2dd3c3,
        0x2ef227708e7128d054963515d48bd541ddc3452fb1b45c1377c09550e9ab9d5,
        0x6b2edd04228ffef61e7182934f21801f1ddd1413c321d7c32cf2c80265c4457,
        0x157dec1391838627b0b457de8f88c0b776fb85a7eec425de6847c42bb44b598,
        0x53b27e2fb6ab47936d8a4705bb8aa49d0c803714c10ef989b7e53c6b84410e2,
        0x6c93ecf7ff3c8b25d5df18aa7587399d7bcee98e4aa3b8c8999dda95a23a141,
        0x7ceb67970b7081049ae30f17dd37dc5cf0af78ae2e441bea5c886cc1e2fa7c7,
        0x5fc4a13262e209a7c567c6df64e2f2002ce6c3ed104c1e0602184aeef727efc,
        0x2a4af8fd4b61d1c86ad29aee18c01d6416c180c7cec7684afe9795d3ab45c55,
        0x332c7e4534a488602aa2f4c3a10e19792d85ac07bf946a4afc9a6ddd1f8f72e,
        0x61e4f6912b0719c0fc9779c632bb7b7dfa6e938cc8e30380ead132f8838e957,
        0x1c3ddeb719ea829b1ba9266f807b17433d89f2a389e8905e81391b55125069,
        0x6c15d84140e38f3d6d8d09da2bfbd02faaa7927613bcc701db2695728b4940,
        0x3cad9cdc9382643788d3dce7037061412b69a824483db5175de5bc219986e43,
        0x5e66321e2b2c09f73bc079b8f66e004f60a01244d97074f003038318ee89b44,
        0x205345c4cdc25c8b016a3b1165c33a56e597b75763fb74ecd7b6438b5fcc54d,
        0x11f95898d99f4887dcc526deefc68a393a858ff75fd71009cf43f861addc85,
        0x421668381458c571ccaa380061c1ccdbc60f5cb3a9368c4a8f767d45b0665a7,
        0x135f1a6848f24d49a8cc0e4519d809d3b6a9af7f64be46b7d4fff4ebb549e50,
        0x342c798c95c7dbe248f3e681ece954eb72ca52412fcf414cc34d35a5b87ba6b,
        0x67eb3e21820d89124365d33c46ff1da1c78327766fb8404f992584b3480eb8d,
        0x7b77a2797301540ba3a506230d974ec272a27d562c87c42865851ea1d286557,
        0xeb6c8b1f5447267ff51c92606b0b552834c6613fdcf0d1922ddc15cd03ee86,
        0x347d74e9f3efe16c4f37e6ec061fd59a6f9791c2c8f2d1506fc729d8f7a727b,
        0x5fe501eb0a68ef4aeec7372f300dceeee7eb0ef64965dedb2890f1b7bcb797f,
        0x4010fc490fcef15d1b06700961b86e24263d6f6f85a6f92fea85bebf016ee0,
        0x5f058f153e46e3a18a56926c4d5d7ac6b66b7a610e3c25ddb85d09f40e1cdfa,
        0x3343de357bf07f000b2cd067ab94151431fd22b66d43b969c8a07b556781459,
        0x6aa840b7ef8951717fb44aa80bfaa92f030ba7e551faa2dca6ea559f47b1036,
        0x50aea635802b82c04d9d245bb1c0a828fbf42430850c670e988ea9a3adb273,
        0x16328010686678a64012342cf8780eb69d35dc02a37046a14d17e117fe32653,
        0x6a5b8f438653f85e13965f3efa1e293323fe2eecb03a0fc3711323b8fbffde9,
        0x2df71baede5d14881a120484d2ca2f75a538e574ed0097161bc23f168717c78,
        0x3228ab385a5b2472dd737bb5bb469689b3570f3773d8b88a7169f60a0eb16f4,
        0x7e984692361c1e6ff30fe7a5bb1ccf7d1bbe653a6f277f04d1200aa4705d29a,
        0x5bcabdae7595c867afe12eb18bc95f826cf369823e656dd08626184b2e8b654,
        0x7b1d4829c3c2b18d7f9f5fc4d7663de2733356a1f7cc9c3e42c8bb547b9f427,
        0x44d1a864879db185a6e7abdaada2adfa01f5f47d48da398b4838d6b8e86b7d8,
        0x29dd0a6cf20f3e19820de66b4760e8a909919c9615077e536d6cc01771889b7,
        0x1a0114e202e05679c3fbf293ccd7825f765217677a6878846eb7b3b7f3c9cc1,
        0x2989dbbe362d7aad523252fd2cebb5d79fb79a716a84c7490c4a2a3724a9fa,
        0x778cb638387227062b17280380a73c992c545860fc1671f5dce50d42f0ae448,
        0x7e05b03997e3301dc32ffbb7829aef7766d0b1bbf6834531aa8a87d83a15a7,
        0x5eacb172e572f42118d31148afff3c5375d0dc7a178ad9210135cd620009fe,
        0x3bfbec45ccdb56aff8d258c1dc71c9bd5a28e6f46607d66fd43ae2bd061bd27,
        0x27d4bf9944ebcbbf92e68964a19fb2a79e905bfc418b6d49b89b573de3e2a40,
        0x7d749cce3aa457f94e2bc440496de97289e78da48cf328ea356747fbc835fde,
        0x181f4bdad37ed027a795ee1666672a3e3b53d2b6bcf7867467cc406fe749549,
        0xc299086b6bbd0092820a438c19ff4ce06568358f7f64833573ba08d6fe190f,
        0x338d815dc41408eb94f16e9b42e573f74a7469edbd4a652db69a609386a44db,
        0x6050a362d64d578210f6c5371d67729f5a638d5abc7a26973d37f76cb79d261,
        0x641adb8cfa3aca2b3c7b487215e372cf712062f69ae7d0230cf567da35fe2b3,
        0x7444e064cfe1158046c6ec3fbed50b0ac06e91ba47f017e260bed4a55426227,
        0x21f37277ff92381f34ee6f54a947595eeb51756f702a7980b14793b66ae49fc,
        0x41d61e80c24153260697d0338b0d167695bf3e0b767269a192ad1f6aced3dae,
        0x6355df894ef081ac1bd6c39757ec20bc61d2e569ddb8aad1ba132b07fc9ee2b,
        0x51c8e992920479261b6c6407bc2d22aaa2aa66f98dd839cc49ec604902d7a07,
        0x57a6cfd6baab8d30837681971bf72688b0e405a4e90aacc001ecd86412a0311,
        0x5d59b5f28c905116785592f98ea089cdacb9efe85115f6e268314a158e41061,
        0x753b588a58b80aaa7878ee8772c7812c7814acba10c5677208cf812c0257f50,
        0x50ac735fa5d8145af47446dc26d7641dd19ade0f990ecfad849d8c03c80f716,
        0x661f34d8ac0088dbbde08f1d143f3f49ffea272f018986aa04acecf35bb9b80,
        0x41181a2dea041a5c052f4ea688236a662cfbb0182ca866880a2201660cf871e,
        0x6118dcd1edbf66400e5eb7333f1fa65e934c4c483f200dca0040392932e211,
        0x63634851fdb2f1685f32e8b817677fc09403cb7259a8c4b544b4164107a699b,
        0x7dde9dee053d505fa789344c14ec9f43e4a0fb86e396b6fdd890d29ac80377c,
        0x100f3f57755c1b4d4c7080c499cf1e407816490b0c117fff8925ff442a24534,
        0x15f4048d23051959f7f104fc0062122af89b45ad008e6cd2a468ff9473b6b2c,
        0x6487b4e3cd3eba9e960835d2a943d2c7dccd897346cb40e0ce29a870f9ac6b9,
        0x31bfa2e39c1becbfa1a788c697293779f2b5bc8b1df04fb9517d2cd7826c8b8,
        0x2ee62cdf7633de8988981b2e723958914d7b20a25c94a410aae9ef93ec9bc97,
        0x374a33e85f4b8648d5849134fd65bce1d09f0e5fbebf29100fbcee47f32e3d1,
        0x35dc098af24cb45c006941b0ce148d320fd03ab0a363fd6e05d39ad6b091f60,
        0x7287981598f1bbc0c494d0af685a404b15682d06fbe1a04a26f777643f4dca8,
        0x304e2c03b25cbc5148d21f0093df26ffd96db5cebc5b4819b6f52da9efc6ef7
    ];

    let point = 0x6a334d04c8fc44e835dd60eb585be69825d6854507921990d90f7553de33ec4;
    let oods_point = 0x47148421d376a8ca07af1e4c89890bf29c90272f63b16103646397d907281a8;
    let trace_generator = 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046;

    assert(
        eval_oods_polynomial_inner(
            column_values.span(),
            oods_values,
            constraint_coefficients.span(),
            point,
            oods_point,
            trace_generator,
        ) == 0x168dc9a375545abcdd0f89474ef29b7603d6ba848e6dc160e0edd5d3a362a3a,
        'Invalid value'
    )
}
