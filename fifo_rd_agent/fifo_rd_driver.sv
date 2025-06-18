class fifo_rd_driver extends uvm_driver #(fifo_rd_tx);
	`uvm_component_utils(fifo_rd_driver)
	`NEW_COMP

	fifo_rd_tx tx;
	virtual fifo_interface fifo_vif;
	function void build();
		`GET_INTRF
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			seq_item_port.get_next_item(tx);
			drive_tx(tx);
			//tx.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(fifo_rd_tx tx);
		@(fifo_vif.rd_cb);
		fifo_vif.rd_cb.rd_en <= tx.rd_en;
		if(tx.rd_en) tx.rdata = fifo_vif.rd_cb.rdata;
		else tx.rdata <=0;
		tx.empty = fifo_vif.rd_cb.empty;
		tx.underflow = fifo_vif.rd_cb.underflow;

		@(fifo_vif.rd_cb);
		fifo_vif.rd_cb.rd_en<=0;
	endtask
endclass
