class fifo_wr_agent extends uvm_agent;
	`uvm_component_utils(fifo_wr_agent)
	`NEW_COMP
	fifo_wr_sequencer wr_sqr;
	fifo_wr_driver wr_drv;
	fifo_wr_mon wr_mon;
	fifo_wr_cov wr_cov;

	function void build();
		wr_sqr=fifo_wr_sequencer::type_id::create("wr_sqr", this);
		wr_drv=fifo_wr_driver::type_id::create("wr_drv", this);
		wr_mon=fifo_wr_mon::type_id::create("wr_mon", this);
		wr_cov = fifo_wr_cov::type_id::create("wr_cov", this);
	endfunction
	
	function void connect();
		wr_drv.seq_item_port.connect(wr_sqr.seq_item_export);
		wr_mon.wr_ap_port.connect(wr_cov.analysis_export);
	endfunction
endclass
