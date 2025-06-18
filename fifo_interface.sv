interface fifo_interface(input wr_clk,rd_clk,res);
	bit wr_en;
	bit [`WIDTH-1:0]wdata;
	bit full;
	bit overflow;
	
	bit [`WIDTH-1:0]rdata;
	bit rd_en;
	bit empty;
	bit underflow;
	
	clocking wr_cb @(posedge wr_clk);
		default input #0 output #1;
		input full;
		input overflow;
		output wr_en;
		output wdata;
	endclocking
	
	clocking rd_cb @(posedge rd_clk);
		default input #0 output #1;
		input empty;
		input underflow;
		input rdata;
		output rd_en;
	endclocking

	clocking wr_mon_cb @(posedge wr_clk);
		default input #0;
		input full;
		input overflow;
		input wr_en;
		input wdata;
	endclocking
	
	clocking rd_mon_cb @(posedge rd_clk);
		default input #0;
		input empty;
		input underflow;
		input rdata;
		input rd_en;
	endclocking

	modport design_mp(
		input wr_clk,rd_clk,res,
		input wr_en,wdata,rd_en,
		output full,overflow,rdata,empty,underflow
	);

	modport assertion_mp(
		input wr_clk,rd_clk,res,
		input wr_en,wdata,rd_en,
		input full,overflow,rdata,empty,underflow
	);
endinterface
