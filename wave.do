onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/fifo_pif/wr_clk
add wave -noupdate /top/fifo_pif/rd_clk
add wave -noupdate /top/fifo_pif/res
add wave -noupdate /top/fifo_pif/wr_en
add wave -noupdate /top/fifo_pif/wdata
add wave -noupdate /top/fifo_pif/full
add wave -noupdate /top/fifo_pif/overflow
add wave -noupdate /top/fifo_pif/rdata
add wave -noupdate /top/fifo_pif/rd_en
add wave -noupdate /top/fifo_pif/empty
add wave -noupdate /top/fifo_pif/underflow
add wave -noupdate /top/uut/RESET_WR_CLK_HIGH
add wave -noupdate /top/uut/RESET_RD_CLK_HIGH
add wave -noupdate /top/uut/RESET_WR_CLK_LOW
add wave -noupdate /top/uut/RESET_RD_CLK_LOW
add wave -noupdate /top/uut/WR_EN_HIGH
add wave -noupdate /top/uut/RD_EN_HIGH
add wave -noupdate /top/uut/WRITE_CHECK_FULL
add wave -noupdate /top/uut/READ_CHECK_EMPTY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
