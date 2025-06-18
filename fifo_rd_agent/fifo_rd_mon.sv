class fifo_rd_mon extends uvm_monitor;
	fifo_rd_tx tx;
	uvm_analysis_port #(fifo_rd_tx) rd_ap_port;

	`uvm_component_utils(fifo_rd_mon)
	`NEW_COMP
	virtual fifo_interface fifo_vif;
	
	function void build();
		super.build();
		`GET_INTRF
		rd_ap_port=new("rd_ap_port", this);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(fifo_vif.rd_mon_cb);
			if(fifo_vif.rd_mon_cb.rd_en) begin
				tx=new();
				tx.rd_en = fifo_vif.rd_mon_cb.rd_en;
				tx.rdata = fifo_vif.rd_mon_cb.rdata;
				tx.empty = fifo_vif.rd_mon_cb.empty;
				tx.underflow = fifo_vif.rd_mon_cb.underflow;
				rd_ap_port.write(tx);
				tx.print();
			end
		end
	endtask
endclass
