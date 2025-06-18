module top;
	logic wr_clk,rd_clk,res;
	fifo_interface fifo_pif(wr_clk,rd_clk,res);
	initial `SET_INTRF
	
	asynchronous_fifo dut(fifo_pif.design_mp);
	fifo_assertion uut(fifo_pif.assertion_mp);
	
	always #5 wr_clk = ~ wr_clk;
	always #7 rd_clk = ~ rd_clk;
	initial begin
		wr_clk=0;
		rd_clk=0;
		res=1;
		repeat(3) @(posedge wr_clk or posedge rd_clk);
		res=0;
	end

	//initial run_test("fifo_base_test");
	//initial run_test("fifo_full_test");
	//initial run_test("fifo_overflow_test");
	//initial run_test("fifo_empty_test");
	//initial run_test("fifo_underflow_test");
	initial run_test("fifo_concurrent_test");
endmodule
