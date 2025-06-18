class fifo_rd_base_seq extends uvm_sequence #(fifo_rd_tx);
	`uvm_object_utils(fifo_rd_base_seq)
	`NEW_OBJ
endclass

class fifo_rd_seq extends fifo_rd_base_seq;
	`uvm_object_utils(fifo_rd_seq)
	`NEW_OBJ
	
	task body();
		repeat(`FIFO_SIZE)
			`uvm_do_with(req, {req.rd_en==1;})
	endtask
endclass

class fifo_rd_underflow_seq extends fifo_rd_base_seq;
	`uvm_object_utils(fifo_rd_underflow_seq)
	`NEW_OBJ
	
	task body();
		repeat(`FIFO_SIZE+1)
			`uvm_do_with(req, {req.rd_en==1;})
	endtask
endclass

class fifo_rd_conc_seq extends fifo_rd_base_seq;
	`uvm_object_utils(fifo_rd_conc_seq)
	`NEW_OBJ
	
	task body();
		wait (fifo_common::wr_drv_count>=1);
		repeat(`FIFO_SIZE)
			`uvm_do_with(req, {req.rd_en==1;})
	endtask
endclass

