`define NEW_OBJ	\
	function new(string name="");	\
		super.new(name);	\
	endfunction

`define NEW_COMP \
	function new(string name="", uvm_component parent);	\
		super.new(name, parent);	\
	endfunction

`define SET_INTRF \
	uvm_config_db#(virtual fifo_interface)::set(uvm_root::get(),"*","vif",fifo_pif);

`define GET_INTRF \
	uvm_config_db#(virtual fifo_interface)::get(this,"","vif",fifo_vif);
