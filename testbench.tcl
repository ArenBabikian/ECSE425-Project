proc AddWaves {} {
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/testbench/clk
		add wave -position end sim:/testbench/dut/IDstg/controller1/IR
    add wave -position end sim:/testbench/reset
    add wave -position end sim:/testbench/dut/IFstg/PCEnable
    add wave -position end sim:/testbench/dut/IFstg/InstructionValue
    add wave -position end sim:/testbench/dut/IFstg/pcout
    add wave -position end sim:/testbench/dut/IFstg/PCClk
    add wave -position end sim:/testbench/data
    add wave -position end sim:/testbench/dut/IDstg/controller1/AluCtr
		add wave -position end sim:/testbench/dut/IFIDbuf/stall_request
		add wave -position end sim:/testbench/dut/IFstg/progcount/pc_sel
		add wave -position end sim:/testbench/dut/IFstg/progcount/jump_in
		add wave -position end sim:/testbench/dut/EXstg/BranchZero1/rs
		add wave -position end sim:/testbench/dut/EXstg/BranchZero1/rt
		add wave -position end sim:/testbench/dut/EXstg/BranchZero1/branchCtrl
		add wave -position end sim:/testbench/dut/EXstg/BranchZero1/BranchTaken
		add wave -position end sim:/testbench/dut/IDstg/registers1/rs
		add wave -position end sim:/testbench/dut/IDstg/registers1/rs_data
		add wave -position end sim:/testbench/dut/IDstg/registers1/rt
		add wave -position end sim:/testbench/dut/IDstg/registers1/rt_data
		add wave -position end sim:/testbench/dut/EXstg/ALU1/Data1
		add wave -position end sim:/testbench/dut/EXstg/ALU1/Data2
		add wave -position end sim:/testbench/dut/EXstg/ALU1/ALUCtr
		add wave -position end sim:/testbench/dut/EXstg/ALU1/ALU_Result
		add wave -position end sim:/testbench/dut/EXstg/ALU1/IR
		add wave -position end sim:/testbench/dut/MEMWBbuf/aludata_in
		add wave -position end sim:/testbench/dut/EXstg/mux1/A
		add wave -position end sim:/testbench/dut/EXstg/mux1/B
		add wave -position end sim:/testbench/dut/EXstg/mux1/SEL
		add wave -position end sim:/testbench/dut/EXstg/mux1/x
		add wave -position end sim:/testbench/dut/IDEXbuf/rs_data_in
		add wave -position end sim:/testbench/dut/IDEXbuf/rs_data_out
		add wave -position end sim:/testbench/dut/EXMEMbuf/ALU_in
		add wave -position end sim:/testbench/dut/EXMEMbuf/ALU_out
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
force -deposit clk 0 1 ns, 1 1 ns -repeat 2 ns

;# Add the waves
AddWaves

;# Run for 20000 ns
run 20000ns
