module fifo_assertion(fifo_interface.assertion_mp mp);
	property reset_wr_clk_h;
		@(posedge mp.wr_clk) (mp.res==1) |=> ##[1:3] (mp.wr_en==0 && mp.wdata==0 && mp.full==0 && mp.overflow==0);
	endproperty
	RESET_WR_CLK_HIGH: assert property (reset_wr_clk_h);

	property reset_rd_clk_h;
		@(posedge mp.rd_clk) (mp.res==1) |=> (mp.rd_en==0 && mp.rdata==0 && mp.empty==1 && mp.underflow==0);
	endproperty
	RESET_RD_CLK_HIGH: assert property (reset_rd_clk_h);

	property reset_wr_clk_l;
		@(posedge mp.wr_clk) (mp.res==0) |=> (!$isunknown(mp.wr_en) && !$isunknown(mp.wdata) && !$isunknown(mp.full) && !$isunknown(mp.overflow));
	endproperty
	RESET_WR_CLK_LOW: assert property (reset_wr_clk_l);

	property reset_rd_clk_l;
		@(posedge mp.rd_clk) (mp.res==0) |=> (!$isunknown(mp.rd_en) && !$isunknown(mp.rdata) && !$isunknown(mp.empty) && !$isunknown(mp.underflow));
	endproperty
	RESET_RD_CLK_LOW: assert property (reset_rd_clk_l);
	
	property wr_en_h;
		@(posedge mp.wr_clk) (mp.wr_en==1) |-> (!$isunknown(mp.wdata));
	endproperty
	WR_EN_HIGH: assert property (wr_en_h);

	property rd_en_h;
		@(posedge mp.rd_clk) (mp.rd_en==1) |-> (!$isunknown(mp.rdata));
	endproperty
	RD_EN_HIGH: assert property (rd_en_h);

	property write_check;
		@(posedge mp.wr_clk) (mp.full==1) |-> ##[1:3] (mp.wr_en==0); 
	endproperty
	WRITE_CHECK_FULL: assert property (write_check);
	
	property read_check;
		@(posedge mp.rd_clk) (mp.empty==1) |=> (mp.rdata==$past(mp.rdata)); 
	endproperty
	READ_CHECK_EMPTY: assert property (read_check);
endmodule

