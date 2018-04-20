proc AddWaves {} {
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/testbench/clk
    add wave -position end sim:/testbench/reset
    add wave -position end sim:/testbench/dut/writeInstrData
	add wave -position end sim:/testbench/dut/IFstg/InstructionConverter/progCount
	add wave -position end sim:/testbench/dut/IFstg/progcount/enable
	add wave -position end sim:/testbench/dut/IFstg/progcount/pc_sel
	add wave -position end sim:/testbench/dut/IFstg/progcount/jump_in
	add wave -position end sim:/testbench/dut/IFstg/progcount/stall
	add wave -position end sim:/testbench/dut/IFstg/progcount/pc_out
	add wave -position end sim:/testbench/dut/IFstg/progcount/next_pc_out
	add wave -position end sim:/testbench/dut/IDstg/controller1/IR
	add wave -position end sim:/testbench/dut/IDstg/controller1/opcode
	add wave -position end sim:/testbench/dut/IDstg/controller1/functionCode
	add wave -position end sim:/testbench/dut/IDstg/controller1/BranchCtrl
	add wave -position end sim:/testbench/dut/IDstg/controller1/Reg1Sel
	add wave -position end sim:/testbench/dut/IDstg/controller1/Reg2Sel
	add wave -position end sim:/testbench/dut/IDstg/registers1/rs
	add wave -position end sim:/testbench/dut/IDstg/registers1/rs_data
	add wave -position end sim:/testbench/dut/IDstg/registers1/rt
	add wave -position end sim:/testbench/dut/IDstg/registers1/rt_data
	add wave -position end sim:/testbench/dut/IDstg/branchzero1/rs_data
	add wave -position end sim:/testbench/dut/IDstg/branchzero1/rt_data
	add wave -position end sim:/testbench/dut/IDstg/branchzero1/branchCtrl
	add wave -position end sim:/testbench/dut/IDstg/branchzero1/BranchTaken
	add wave -position end sim:/testbench/dut/IDstg/bdest1/branchCtrl
	add wave -position end sim:/testbench/dut/IDstg/bdest1/extendData
	add wave -position end sim:/testbench/dut/IDstg/bdest1/pc_in
	add wave -position end sim:/testbench/dut/IDstg/bdest1/IR
	add wave -position end sim:/testbench/dut/IDstg/bdest1/b_dest

	;#add log -r sim:/testbench/dut/*










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
vcom memoryInstr.vhd
vcom MEMWB_buffer.vhd
vcom mux.vhd
vcom PC.vhd
vcom Pipeline.vhd
vcom Registers.vhd
vcom testbench.vhd
vcom WB.vhd
vcom mux4to1.vhd
vcom forwarding.vhd


;# Start simulation
vsim testbench

;# Generate a clock with 1ns period
force -deposit clk 0 1 ns, 1 1 ns -repeat 2 ns

;# Add the waves
AddWaves

;# Run for 20000 ns
run 70000ns
