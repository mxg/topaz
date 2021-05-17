class packet;

  bit [15:0] src_addr;
  bit [15:0] dst_addr;
  bit [15:0] payload_length;
  byte 	     payload[];

  function void set_src_addr(bit[15:0] addr);
    src_addr = addr;
  endfunction

  function void set_dst_addr(bit[15:0] addr);
    dst_addr =  addr;
  endfunction

  function void set_payload_length(bit[15:0] len);
    payload_length = len;
  endfunction

  function void set_payload(ref byte data[]);
    payload = data;
  endfunction

endclass;
