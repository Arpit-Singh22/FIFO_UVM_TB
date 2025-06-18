class fifo_rd_cov extends uvm_subscriber #(fifo_rd_tx);
	`uvm_component_utils(fifo_rd_cov)
	fifo_rd_tx tx;

	covergroup fifo_cg;
		option.name="Read Async covergroup";
		RD_EN:coverpoint tx.rd_en {
			bins rd_en = {1};
		}
		RDATA:coverpoint tx.rdata{
			option.auto_bin_max=8;
		}
		EMPTY:coverpoint tx.empty {
			bins empty0 = {0};
			bins empty1 = {1};
		}
		UNDERFLOW:coverpoint tx.underflow{
			bins underflow0 = {0};
			bins underflow1 = {1};
		}
	endgroup

	function new(string name="", uvm_component parent);
		super.new(name, parent);
		fifo_cg=new();
	endfunction
	
	function void write(fifo_rd_tx t);
		tx = new t;
		fifo_cg.sample();
	endfunction
endclass
