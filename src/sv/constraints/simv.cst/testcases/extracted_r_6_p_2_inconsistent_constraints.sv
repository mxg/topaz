class c_6_2;
    integer last_op = 0; // ( last_op = constraints_pkg::op_t::NOP ) 
    integer n = 0;
    rand integer op; // rand_mode = ON 

    constraint rw_this    // (constraint_mode = ON) (trans_rw.svh:33)
    {
       ((op == 1 /* constraints_pkg::op_t::READ */) || (op == 2 /* constraints_pkg::op_t::WRITE */));
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (generate_trans.svh:61)
    {
       ((n % 5) == 0) -> (op == last_op);
    }
endclass

program p_6_2;
    c_6_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0x0100x1z01x1xx0xx00zx0001x110zzxxxxzxxxxxzzxxxzzxzxxzzxzzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram