//------------------------------------------------------------------------------
//                 .
//               .o8
//             .o888oo  .ooooo.  oo.ooooo.   .oooo.     oooooooo
//               888   d88' `88b  888' `88b `P  )88b   d'""7d8P
//               888   888   888  888   888  .oP"888     .d8P'
//               888 . 888   888  888   888 d8(  888   .d8P'  .P
//               "888" `Y8bod8P'  888bod8P' `Y888""8o d8888888P
//                                888
//                               o888o
//
//                 T O P A Z   P A T T E R N   L I B R A R Y 
//
//    TOPAZ is a library of SystemVerilog and UVM patterns and idioms.  The
//    code is suitable for study and for copying/pasting into your own work.
//------------------------------------------------------------------------------

class initiator extends uvm_component;

  uvm_tlm_b_initiator_socket #(uvm_tlm_generic_payload) initiator_socket;  

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    initiator_socket = new("b_transport_socket", this);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_tlm_generic_payload gp;
    
    byte unsigned byte_enables[];
    uvm_tlm_time delay = new("delay", 1.0e-9);

    for(int i = 0; i< 10; i++) begin
      gp = populate_randomized_generic_payload();
      initiator_socket.b_transport(gp, delay);
    end
    
  endtask

  function uvm_tlm_generic_payload populate_randomized_generic_payload();
    uvm_tlm_generic_payload gp;
    bit [63:0] addr;
    byte unsigned data[];
    int unsigned  data_size;  
    byte unsigned byte_enables[];

    gp = new();
    gp.set_write();
    addr = ($urandom() << 32) | $urandom();
    gp.set_address(addr);
    data_size = ($urandom() & 'hff) + 256;
    data  = new [data_size];
    for(int i = 0; i < data_size; i++) begin
      data[i] = $urandom() & 'hff;
    end
    gp.set_data(data);
    gp.set_data_length(data_size);
    byte_enables = new [data_size];
    for(int i = 0; i < data_size; i++) begin
      byte_enables[i] = 'hff;
    end
    gp.set_byte_enable(byte_enables);
    gp.set_byte_enable_length(data_size);
    gp.set_response_status(UVM_TLM_INCOMPLETE_RESPONSE);
    gp.set_dmi_allowed(0);

    return gp;    
  endfunction

endclass

  
  
