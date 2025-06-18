class fifo_wr_base_seq extends uvm_sequence #(fifo_wr_tx);
	`uvm_object_utils(fifo_wr_base_seq)
	`NEW_OBJ
	
endclass

class fifo_wr_seq extends uvm_sequence #(fifo_wr_tx);
	`uvm_object_utils(fifo_wr_seq)
	`NEW_OBJ
	
	task body();
		fifo_common::wr_tx_count=`FIFO_SIZE;
		repeat(`FIFO_SIZE) 
			`uvm_do_with(req, {req.wr_en==1;})
	endtask
endclass


class fifo_full_seq extends uvm_sequence #(fifo_wr_tx);
	`uvm_object_utils(fifo_full_seq)
	`NEW_OBJ
	
	task body();
		repeat(`FIFO_SIZE) 
			`uvm_do_with(req, {req.wr_en==1;})
	endtask
endclass

class fifo_overflow_seq extends uvm_sequence #(fifo_wr_tx);
	`uvm_object_utils(fifo_overflow_seq)
	`NEW_OBJ
	
	task body();
		repeat(`FIFO_SIZE+1) 
			`uvm_do_with(req, {req.wr_en==1;})
	endtask
endclass

