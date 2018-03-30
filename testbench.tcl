proc AddWaves {} {
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/pipeline_tb/clk
    add wave -position end sim:/pipeline_tb/s_a
    add wave -position end sim:/pipeline_tb/s_b
    add wave -position end sim:/pipeline_tb/s_c
    add wave -position end sim:/pipeline_tb/s_d
    add wave -position end sim:/pipeline_tb/s_e
    add wave -position end sim:/pipeline_tb/s_op1
    add wave -position end sim:/pipeline_tb/s_op2
    add wave -position end sim:/pipeline_tb/s_op3
    add wave -position end sim:/pipeline_tb/s_op4
    add wave -position end sim:/pipeline_tb/s_op5
    add wave -position end sim:/pipeline_tb/s_final_output
}

vlib work

;# Compile components if any
vcom add4.vhd
vcom ALU.vhd
vcom BranchZero.vhd
vcom Controller.vhd
vcom EX.vhd
vcom EXMEM_buffer.vhd
vcom ExtImm.vhd
vcom hazard_detection.vhd
vcom ID.vhd
vcom IDEX_buffer.vhd
vcom IFID_buffer.vhd
vcom IFStage.vhd
vcom InstrMem.vhd
vcom MEM.vhd
vcom Memory.vhd
vcom MEMWB_buffer.vhd
vcom mux.vhd
vcom PC.vhd
vcom Pipeline.vhd
vcom Registers.vhd
vcom testbench.vhd
vcom WB.vhd


;# Start simulation
vsim testbench

;# Generate a clock with 1ns period
force -deposit clk 0 0 ns, 1 0.5 ns -repeat 1 ns

#;# Add the waves
#AddWaves

;# Run for 20000 ns
run 20000ns