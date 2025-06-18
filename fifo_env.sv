class fifo_env extends uvm_env;
	`uvm_component_utils(fifo_env)
	`NEW_COMP

	fifo_wr_agent wr_agent;
	fifo_rd_agent rd_agent;
	fifo_sbd sbd;
	
	function void build();
		wr_agent=fifo_wr_agent::type_id::create("wr_agent", this);
		rd_agent=fifo_rd_agent::type_id::create("rd_agent", this);
		sbd = fifo_sbd::type_id::create("sbd", this);
	endfunction

	function void connect();
		wr_agent.wr_mon.wr_ap_port.connect(sbd.wr_ap_imp);
		rd_agent.rd_mon.rd_ap_port.connect(sbd.rd_ap_imp);
	endfunction
endclass
