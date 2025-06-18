class fifo_rd_tx extends uvm_sequence_item;
	rand bit rd_en;
	     bit [`WIDTH-1:0]rdata;
		 bit empty;
		 bit underflow;
	`uvm_object_utils_begin(fifo_rd_tx)
		`uvm_field_int(rd_en, UVM_ALL_ON)
		`uvm_field_int(rdata, UVM_ALL_ON)
		`uvm_field_int(empty, UVM_ALL_ON)
		`uvm_field_int(underflow, UVM_ALL_ON)
	`uvm_object_utils_end
	`NEW_OBJ
endclass
