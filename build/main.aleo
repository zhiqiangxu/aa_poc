program aa_poc.aleo;



mapping balances:
	key left as address.public;
	value right as u128.public;

function transfer:
    input r0 as scalar.private;
    input r1 as scalar.private;
    input r2 as address.private;
    input r3 as u128.private;
    mul group::GEN r0 into r4;
    hash.psd8 r4 into r5 as scalar;    mul group::GEN r1 into r6;
    hash.psd8 r6 into r7 as scalar;    add r5 r7 into r8;

    finalize r2 r2 r3;

finalize transfer:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u128.public;
    get.or_use balances[r0] 0u128 into r3;
    get.or_use balances[r1] 0u128 into r4;
    gte r3 r2 into r5;
    assert.eq r5 true;
    sub r3 r2 into r6;
    set r6 into balances[r0];
    add r4 r2 into r7;
    set r7 into balances[r1];
