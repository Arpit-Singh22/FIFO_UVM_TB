class fifo_base_test extends uvm_test;
	`uvm_component_utils(fifo_base_test)
	`NEW_COMP

	fifo_env env;

	function void build();
		env=fifo_env::type_id::create("env", this);
	endfunction
	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction
endclass

class fifo_full_test extends fifo_base_test;
	`uvm_component_utils(fifo_full_test)
	`NEW_COMP
	
	task run_phase(uvm_phase phase);
		fifo_full_seq wr_seq=fifo_full_seq::type_id::create("fifo_full_seq");  
		super.run_phase(phase);
		phase.raise_objection(this);
		wr_seq.start(env.wr_agent.wr_sqr);
		phase.phase_done.set_drain_time(this,15);
		phase.drop_objection(this);
	endtask
endclass

class fifo_overflow_test extends fifo_base_test;
	`uvm_component_utils(fifo_overflow_test)
	`NEW_COMP
	
	task run_phase(uvm_phase phase);
		fifo_overflow_seq wr_seq=fifo_overflow_seq::type_id::create("fifo_overflow_seq");  
		super.run_phase(phase);
		phase.raise_objection(this);
		wr_seq.start(env.wr_agent.wr_sqr);
		phase.phase_done.set_drain_time(this,15);
		phase.drop_objection(this);
	endtask
endclass

class fifo_empty_test extends fifo_base_test;
	`uvm_component_utils(fifo_empty_test)
	`NEW_COMP
	
	task run_phase(uvm_phase phase);
		fifo_wr_seq wr_seq=fifo_wr_seq::type_id::create("fifo_wr_seq");  
		fifo_rd_seq rd_seq=fifo_rd_seq::type_id::create("fifo_rd_seq");  
		super.run_phase(phase);
		phase.raise_objection(this);
		wr_seq.start(env.wr_agent.wr_sqr);
		rd_seq.start(env.rd_agent.rd_sqr);
		phase.phase_done.set_drain_time(this,15);
		phase.drop_objection(this);
	endtask
endclass

class fifo_underflow_test extends fifo_base_test;
	`uvm_component_utils(fifo_underflow_test)
	`NEW_COMP
	
	task run_phase(uvm_phase phase);
		fifo_wr_seq wr_seq=fifo_wr_seq::type_id::create("fifo_wr_seq");  
		fifo_rd_underflow_seq rd_seq=fifo_rd_underflow_seq::type_id::create("fifo_rd_underflow_seq");  
		super.run_phase(phase);
		phase.raise_objection(this);
		wr_seq.start(env.wr_agent.wr_sqr);
		rd_seq.start(env.rd_agent.rd_sqr);
		phase.phase_done.set_drain_time(this,15);
		phase.drop_objection(this);
	endtask
endclass

class fifo_concurrent_test extends fifo_base_test;
	`uvm_component_utils(fifo_concurrent_test)
	`NEW_COMP
	
	task run_phase(uvm_phase phase);
		fifo_wr_seq wr_seq=fifo_wr_seq::type_id::create("fifo_wr_seq");  
		fifo_rd_conc_seq rd_seq=fifo_rd_conc_seq::type_id::create("fifo_rd_conc_seq"); 
		super.run_phase(phase);
		phase.raise_objection(this);
		fork
		wr_seq.start(env.wr_agent.wr_sqr);
		rd_seq.start(env.rd_agent.rd_sqr);
		join
		phase.phase_done.set_drain_time(this,15);
		phase.drop_objection(this);
	endtask
endclass

