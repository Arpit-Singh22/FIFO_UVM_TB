vlog list.svh +incdir+C:/uvm-1.2/src
vopt work.top +cover=fcbest -o fifo_concurrent_test
vsim -novopt -suppress 12110 \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi \
-coverage fifo_concurrent_test
coverage save -onexit CONCURRENT.ucdb
#add wave -position insertpoint sim:/top/fifo_pif/*
do wave.do
run -all 
