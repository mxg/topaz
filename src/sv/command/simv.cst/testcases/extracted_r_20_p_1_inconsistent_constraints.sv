class c_20_1;
    bit[31:0] dest_addr = 32'h0;

    constraint c_this    // (constraint_mode = ON) (dma.svh:46)
    {
       (dest_addr & (32'h3 == 0));
    }
endclass

program p_20_1;
    c_20_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00z1zzz1z0zz11xzx11z1zx1xz1z0x01xzzzzzxzxzxzzzzxxxxzzxzzxxzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
