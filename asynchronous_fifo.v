`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)

module asynchronous_fifo(fifo_interface.design_mp mp);
	reg [`WIDTH-1:0]fifo[`FIFO_SIZE-1:0];
	reg [`PTR_WIDTH-1:0]rd_ptr,wr_ptr,rd_ptr_wr_clk,wr_ptr_rd_clk;
	reg rd_toggle_f,wr_toggle_f,wr_toggle_f_rd_clk, rd_toggle_f_wr_clk;
	reg [`PTR_WIDTH-1:0]rd_ptr_grey,wr_ptr_grey;
	integer i;

	always @(posedge mp.wr_clk) begin
		if(mp.res) begin
			mp.full <= 0;
			mp.overflow <= 0;
			wr_ptr <= 0;
			rd_ptr_wr_clk <= 0;
			wr_toggle_f <=0;
			rd_toggle_f_wr_clk <= 0;
			for(i=0;i<`FIFO_SIZE;i=i+1) fifo[i] <= 0;
		end else begin
			if(mp.wr_en) begin
				if(mp.full) mp.overflow <= 1;
				else begin
					mp.overflow <= 0;
					fifo[wr_ptr] <= mp.wdata;
					if(wr_ptr==`FIFO_SIZE-1) begin
						wr_toggle_f <= ~wr_toggle_f;
						wr_ptr <= 0;
					end
					else wr_ptr <= wr_ptr+1;
				end	
			end
			else mp.overflow <= 0;
		end
	end

	always @(posedge mp.rd_clk) begin
		if(mp.res) begin
			mp.empty <= 1;
			mp.underflow <= 0;
			rd_ptr <=0;
			rd_toggle_f <= 0;
			wr_toggle_f_rd_clk <= 0;
			wr_ptr_rd_clk <= 0;
		end else begin
			if(mp.rd_en) begin
				if(mp.empty) mp.underflow <= 1;
				else begin
					mp.underflow <= 0;
					mp.rdata <= fifo[rd_ptr];
					if(rd_ptr == `FIFO_SIZE-1) begin
						rd_toggle_f <= ~rd_toggle_f;
						rd_ptr <= 0;
					end
					else rd_ptr <= rd_ptr + 1;
				end
			end
			else mp.underflow <= 0;
		end
	end

	assign wr_ptr_grey = (wr_ptr>>1)^wr_ptr;
	assign rd_ptr_grey = (rd_ptr>>1)^rd_ptr;
	
	always @(posedge mp.wr_clk) begin
		rd_ptr_wr_clk <= rd_ptr_grey;
		rd_toggle_f_wr_clk <= rd_toggle_f;
	end
	
	always @(posedge mp.rd_clk) begin
		wr_ptr_rd_clk <= wr_ptr_grey;
		wr_toggle_f_rd_clk <= wr_toggle_f;
	end
	
	always @(*) begin
		if(wr_ptr_grey == rd_ptr_wr_clk && wr_toggle_f != rd_toggle_f_wr_clk) mp.full=1;
		else mp.full = 0;
		
		if(wr_ptr_rd_clk == rd_ptr_grey && wr_toggle_f_rd_clk == rd_toggle_f) mp.empty=1;
		else mp.empty = 0;
	end
endmodule
