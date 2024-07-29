use cairo_verifier::air::layouts::dex::global_values::GlobalValues;

#[starknet::interface]
trait IDexLayoutContract1<ContractState> {
    fn eval_composition_polynomial_inner(
        self: @ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    ) -> felt252;
}

#[starknet::interface]
trait IDexLayoutContract2<ContractState> {
    fn eval_oods_polynomial_inner(
        self: @ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}

#[starknet::contract]
mod DexLayoutContract1 {
    use super::IDexLayoutContract1;
    use cairo_verifier::air::layouts::dex::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DexLayoutContract1 of IDexLayoutContract1<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod DexLayoutContract2 {
    use super::IDexLayoutContract2;
    use cairo_verifier::air::layouts::dex::{
        global_values::GlobalValues,
        autogenerated::eval_oods_polynomial_inner,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DexLayoutContract2 of IDexLayoutContract2<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner(
                column_values,
                oods_values,
                constraint_coefficients,
                point,
                oods_point,
                trace_generator,
            )
        }
    }
}