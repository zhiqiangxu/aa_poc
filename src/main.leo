// The 'aa_poc' program.
program aa_poc.aleo {

    mapping balances : address => u128;

    transition transfer( user:string,  password:string,  to:address,  amount:u128) {
        let from: scalar = Poseidon8::hash_to_scalar(group::GEN* user) + Poseidon8::hash_to_scalar(group::GEN*password);
        return then finalize( from,to,amount);
    }

    finalize transfer(from: address, to:address,  amount:u128) {
        let from_balance :u128 = Mapping::get_or_use(balances,from, 0u128);
        let to_balance:u128 = Mapping::get_or_use(balances,to, 0u128 );
        assert(from_balance>=amount);
        Mapping::set(balances, from, from_balance-amount);
        Mapping::set(balances, to, to_balance+amount);
    }

}
