`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class fifo_sbd extends uvm_scoreboard;
	`uvm_component_utils(fifo_sbd)
	
	uvm_analysis_imp_wr#(fifo_wr_tx, fifo_sbd) wr_ap_imp;
	uvm_analysis_imp_rd#(fifo_rd_tx, fifo_sbd) rd_ap_imp;
	
	fifo_wr_tx wr_tx, wr_que[$];
	fifo_rd_tx rd_tx;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		wr_ap_imp = new("wr_ap_imp", this);
		rd_ap_imp = new("rd_ap_imp", this);
	endfunction
	int value;

	function void write_wr(fifo_wr_tx tx);
		if(tx.wr_en) wr_que.push_back(tx);
	endfunction

	function void write_rd(fifo_rd_tx tx);
		if(tx.rd_en && wr_que.size()!=0) begin
			wr_tx = wr_que.pop_front();
			if(wr_tx.wdata == tx.rdata) fifo_common::matchings++;
			else fifo_common::mismatchings++;
		end		
	endfunction	

	function void check();
		`uvm_info("SBD", $sformatf("Total matches: %0d, mismatches: %0d", 
              fifo_common::matchings, fifo_common::mismatchings), UVM_LOW)

  		if (fifo_common::matchings != 0 && fifo_common::mismatchings == 0)
    		`uvm_info("SBD", "TEST PASSED : All transactions matched", UVM_NONE)
  		else
    		`uvm_error("SBD", "TEST FAILED : Mismatched transactions detected")
	endfunction
endclass
