class fifo_wr_cov extends uvm_subscriber #(fifo_wr_tx);
	`uvm_component_utils(fifo_wr_cov)
	fifo_wr_tx tx;
	
	covergroup fifo_cg;
		option.name="Write Async covergroup";
		WR_EN:coverpoint tx.wr_en {
			bins wr_en1 = {1'b1};
		}
		WDATA:coverpoint tx.wdata{
			option.auto_bin_max=8;
		}
		FULL:coverpoint tx.full {
			bins full0= {1'b0};
			bins full1= {1'b1};
		}
		OVERFLOW:coverpoint tx.overflow{
			bins overflow0 = {1'b0};
			bins overflow1 = {1'b1};
		}
	endgroup

	function new(string name="", uvm_component parent);
		super.new(name, parent);
		fifo_cg=new();
	endfunction

	function void write(fifo_wr_tx t);
		tx = new t;
		fifo_cg.sample();
	endfunction
endclass
