class fifo_wr_driver extends uvm_driver #(fifo_wr_tx);
	`uvm_component_utils(fifo_wr_driver)
	`NEW_COMP

	fifo_wr_tx tx;
	virtual fifo_interface fifo_vif;
	function void build();
		`GET_INTRF
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		wait (fifo_vif.res==0);
		forever begin
			seq_item_port.get_next_item(tx);
			drive_tx(tx);
			//tx.print();
			fifo_common::wr_drv_count++;
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(fifo_wr_tx tx);
		@(fifo_vif.wr_cb);
		fifo_vif.wr_cb.wr_en <= tx.wr_en;
		if(tx.wr_en) fifo_vif.wr_cb.wdata <= tx.wdata;
		else fifo_vif.wr_cb.wdata <=0;
				
		@(fifo_vif.wr_cb);
		fifo_vif.wr_cb.wr_en<=0;
		fifo_vif.wr_cb.wdata<=0;
		
		tx.full=fifo_vif.wr_cb.full;
		tx.overflow=fifo_vif.wr_cb.overflow;

	endtask
endclass
