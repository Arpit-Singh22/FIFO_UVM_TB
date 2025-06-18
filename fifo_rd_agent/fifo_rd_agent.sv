class fifo_rd_agent extends uvm_agent;
	`uvm_component_utils(fifo_rd_agent)
	`NEW_COMP
	fifo_rd_sequencer rd_sqr;
	fifo_rd_driver rd_drv;
	fifo_rd_mon rd_mon;
	fifo_rd_cov rd_cov;
	
	function void build();
		rd_sqr=fifo_rd_sequencer::type_id::create("rd_sqr", this);
		rd_drv=fifo_rd_driver::type_id::create("rd_drv",this);
		rd_mon=fifo_rd_mon::type_id::create("rd_mon", this);
		rd_cov=fifo_rd_cov::type_id::create("rd_cov", this);
	endfunction
	
	function void connect();
		rd_drv.seq_item_port.connect(rd_sqr.seq_item_export);
		rd_mon.rd_ap_port.connect(rd_cov.analysis_export);
	endfunction
endclass
