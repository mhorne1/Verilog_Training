vlib work
vlog adder.v
vlog mult4x4.v
vlog mux4.v
vlog shifter.v
vlog seven_segment_cntrl.v
vlog reg16.v
vlog counter.v
vlog mult_control.v
vlog cpu_if.v
vlog mult8x8.v
vlog dual_mult8x8_top.v dual_mult8x8_top_tb.v
vsim -t ns work.dual_mult8x8_top_tb
view wave
#
configure wave -signalnamewidth 1
#
add wave -height 20 -divider "Control Signals"
add wave -radix binary /clk
add wave -radix binary /reset_al
add wave -radix hex /address
add wave -radix hex /data
add wave -radix binary /cs
add wave -radix binary /wr
add wave -radix binary /rd
add wave -radix hex /drvdata
#
add wave -height 20 -divider "Mul 1 Registers"
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/data_a1
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/data_b1
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/start_1
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/done_flag_1
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/product_1
#
add wave -height 20 -divider "Mul 2 Registers"
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/data_a2
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/data_b2
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/start_2
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/done_flag_2
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/product_2
#
add wave -height 20 -divider "mult8x8_i1 Internal"
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/start
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/dataa
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/datab
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/done_flag
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/product8x8_out
#
add wave -height 20 -divider "mult8x8_i2 Internal"
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i2/start
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i2/dataa
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i2/datab
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i2/done_flag
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i2/product8x8_out
#
add wave -height 20 -divider "Control Registers"
add wave -radix hex /dual_mult8x8_top_tb/dual_mult8x8_top_i/data_out
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/drive
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/ghost_start_1
add wave -radix binary /dual_mult8x8_top_tb/dual_mult8x8_top_i/ghost_start_2
#
#add wave -height 20 -divider "Internal Signals"
#add wave /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/state_out
#add wave /dual_mult8x8_top_tb/dual_mult8x8_top_i/mult8x8_i1/u6/current_state
#
run 4 us
