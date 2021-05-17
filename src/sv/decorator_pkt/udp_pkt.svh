class udp_pkt;

  packet pkt;
  bit [15:0] checksum;

  function new();
    pkt = new();
  endfunction

  function void set_src_addr(bit[15:0] addr);
    pkt.set_src_addr(addr);
  endfunction

  function void set_dst_addr(bit[15:0] addr);
    pkt.set_dst_addr(addr);
  endfunction

  function void set_payload_length(bit[15:0] len);
    pkt.set_payload_length(len);
  endfunction

  function void set_payload(ref byte data[]);
    pkt.set_payload(data);
  endfunction

  function void set_checksum(bit[15:0] cksum);
    checksum = cksum;
  endfunction

endclass

