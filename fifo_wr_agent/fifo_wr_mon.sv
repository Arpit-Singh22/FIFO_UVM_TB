class fifo_wr_mon extends uvm_monitor;
	fifo_wr_tx tx;
	virtual fifo_interface fifo_vif;
	uvm_analysis_port #(fifo_wr_tx) wr_ap_port;
	//`uvm_analysis_imp_decl(_wr)

	`uvm_component_utils(fifo_wr_mon)
	`NEW_COMP
	function void build();
		`GET_INTRF
		wr_ap_port=new("wr_ap_port", this);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(fifo_vif.wr_mon_cb);
			if(fifo_vif.wr_mon_cb.wr_en) begin
				tx=new();
				tx.wr_en = fifo_vif.wr_mon_cb.wr_en;
				tx.wdata = fifo_vif.wr_mon_cb.wdata;
				tx.full = fifo_vif.wr_mon_cb.full;
				tx.overflow = fifo_vif.wr_mon_cb.overflow;
				wr_ap_port.write(tx);
				tx.print();
			end
		end
	endtask
endclass
