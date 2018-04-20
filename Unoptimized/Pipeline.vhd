library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
-- Main pipeline processor module
entity pipeline is
port (
	clk : in std_logic;
	reset : in std_logic;
	initializeMem : in std_logic;
	writeInstrData : in std_logic_vector(31 DOWNTO 0);
	memoryread : in std_logic;
	address_data : in std_logic_vector(31 DOWNTO 0);
	data : out std_logic_vector(31 DOWNTO 0);
	registerRead : in std_logic;
	register_address : in std_logic_vector(4 DOWNTO 0);
	registerData : out std_logic_vector(31 DOWNTO 0);
	pc_enable : in std_logic);
end pipeline;

architecture behavioral of pipeline is

	--BUFFER COMPONENTS
	Component IFID_buffer is
		PORT( clock : IN STD_LOGIC;
		      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      stall_request : IN STD_LOGIC;
		      IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	END component;

	Component IDEX_buffer is
		PORT(	clock : IN STD_LOGIC;
		      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      rs_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      rt_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      extendData_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		      SEL1_in : IN STD_LOGIC;
		      SEL2_in : IN STD_LOGIC;
		      ALUCtr_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		      WriteToReg_in : IN STD_LOGIC;
		      WriteToMem_in : IN STD_LOGIC;
		      BranchCtrl_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      rs_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      rt_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      extendData_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		      SEL1_out : OUT STD_LOGIC;
		      SEL2_out : OUT STD_LOGIC;
		      ALUCtr_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		      WriteToReg_out : OUT STD_LOGIC;
		      WriteToMem_out : OUT STD_LOGIC;
		      BranchCtrl_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	        IRTypeIDEX_in : in INTEGER;
	        IRTypeIDEX_out : out INTEGER);

	END component;

	Component EXMEM_buffer is
		PORT ( clock : IN STD_LOGIC;
		       Branch_Taken_in : IN STD_LOGIC;
		       ALU_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		       rt_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		       IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		       WriteToRegInEXMEM : IN STD_LOGIC;
		       WriteToMemInEXMEM : IN STD_LOGIC;
		       WriteToRegOutEXMEM : OUT STD_LOGIC;
		       WriteToMemOutEXMEM : OUT STD_LOGIC;
		       Branch_Taken_out : OUT STD_LOGIC;
		       ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		       rt_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		       IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	         IRTypeEXMEM_in : in INTEGER;
	         IRTypeEXMEM_out : out INTEGER);
	END component;

	Component MEMWB_buffer is
		PORT( clock : IN STD_LOGIC;
			memdata_in : IN std_logic_vector (31 downto 0);
			aludata_in : IN std_logic_vector (31 downto 0);
			IR_in : IN std_logic_vector (31 downto 0);
			WriteToReg_in : IN std_logic;
			memdata_out : out std_logic_vector (31 downto 0);
			aludata_out : out std_logic_vector (31 downto 0);
			IR_out : out std_logic_vector (31 downto 0);
			WriteToReg_out : OUT std_logic;
			IRTypeMEMWB_in : in INTEGER;
			IRTypeMEMWB_out : out INTEGER;
			rt_data_in : IN std_logic_vector(31 DOWNTO 0);
			rt_data_out : out std_logic_vector(31 DOWNTO 0));
	END component;

	--STAGE COMPONENTS
	Component IFStage is
		 PORT( SELMUX : IN STD_LOGIC;
      	MUXBRANCHIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      	PCEnable : IN STD_logic;
      	PCClk : IN STD_Logic;
      	PCRESET : IN STD_Logic;
        writeInstrData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        initializeMem : IN STD_LOGIC;
        NEXT_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	      InstructionValue : OUT STD_LOGIC_VECTOR(31 downto 0);
        stall : IN STD_Logic);
	END component;

	Component ID is
		PORT(
			clock : IN STD_LOGIC;
		    reset : IN STD_LOGIC;
		    IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    wb_mux : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    memwb_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		    reg_en : IN STD_LOGIC;
		    IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    rs_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    rt_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    extendData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		    SEL1 : OUT STD_LOGIC;
		    SEL2 : OUT STD_LOGIC;
		    ALUCtr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		    WriteToReg : OUT STD_LOGIC;
		    WriteToMem : OUT STD_LOGIC;
		    BranchCtrl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			readRegister : in std_logic;
			register_address : in std_logic_vector(4 DOWNTO 0);
			IRTypeID_in : in INTEGER;
			IRTypeID_out : out INTEGER);
	END component;

	Component EX is
	PORT( pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rs_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rt_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        extendData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SEL1 : IN STD_LOGIC;
        SEL2 : IN STD_LOGIC;
        forward_A : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        forward_B : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        forward_C : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        exmem_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        memwb_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUCtr1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        BranchCtrl1: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Branch_Taken :  OUT STD_LOGIC;
        rt_data_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IRTypeEX_in : in INTEGER;
        IRTypeEX_out : out INTEGER;
        rt_exmem_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rt_memwb_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
	End Component;	

	Component MEM is
		PORT( clock : IN STD_LOGIC;
				AluData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				WriteDataMem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				mem_en : IN STD_LOGIC;
				MemoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				AluDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				IR_Out : OUT STD_LOGIC_VECTOR(31 downto 0);
				readmemory : in std_logic;
				data_address : in std_logic_vector(31 DOWNTO 0);
        IRTypeMEM_in : in INTEGER;
        IRTypeMEM_out : out INTEGER;
				rt_data_out : out STD_LOGIC_VECTOR(31 DOWNTO 0));
	END component;

	Component WB is
		PORT(
					mem_in : IN std_logic_vector (31 downto 0);
					alu_in  : IN std_logic_vector (31 downto 0);
					ir_in : IN std_logic_vector (31 downto 0);
					mux_out : out std_logic_vector (31 downto 0);
					ir_out : out std_logic_vector (31 downto 0);
	        IRTypeWB_in : in INTEGER;
	        IRTypeWB_out : out INTEGER);
	END component;

	--Hazard Detection and Forwarding
	component hazard_detection is
		PORT( clock : IN STD_LOGIC;
        ifid_IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        STALL_REQUEST : OUT STD_LOGIC);
	end component;

	component forwarding is
		PORT( exmem_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      memwb_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ir: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      idex_type : IN INTEGER;
      forward_A : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forward_B : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forward_C : out STD_LOGIC_VECTOR(1 DOWNTO 0);
      IRTypeEXMEM_in : in INTEGER;
      IRTypeMEMWB_in : in INTEGER);
	end component;

-- Signals connecting the stages and buffers together
-- IF stage
SIGNAL if_NEXT_PC , if_InstructionValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL pc_en : STD_LOGIC;
-- IF/ID buffer
SIGNAL ifid_ir_out, ifid_pc_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
-- ID stage
SIGNAL if_ir_out , if_pc_out , if_rs_data , if_rt_data , if_extend_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL if_ALU_ctrl : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL if_branch_ctrl : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL if_sel1 , if_sel2 , if_write_to_reg , if_write_to_mem : STD_LOGIC;
SIGNAL ir_typeID_out : INTEGER;
-- ID/EX buffer
SIGNAL idex_pc_out , idex_rs_data_out , idex_rt_data_out , idex_extendData_out , idex_IR_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL idex_SEL1_out , idex_SEL2_out , idex_WriteToReg_out, idex_WriteToMem_out: STD_LOGIC;
SIGNAL idex_ALUCtr_out : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL idex_BranchCtrl_out : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ir_typeIDEX_out : INTEGER;

-- EX stage
SIGNAL ex_ALU_OUT , ex_rt_data_OUT , ex_IR_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ex_Branch_Taken : STD_LOGIC;
SIGNAL not_Sel_1 : STD_LOGIC;
SIGNAL ir_typeEX_out : INTEGER;

-- EX/MEM buffer
SIGNAL exmem_WriteToRegOutEXMEM , exmem_WriteToMemOutEXMEM , exmem_Branch_Taken_out : STD_LOGIC;
SIGNAL exmem_ALU_out , exmem_rt_data_out , exmem_IR_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ir_typeEXMEM_out : INTEGER;

-- MEM stage
SIGNAL mem_MemoryData , mem_AluDataOut , mem_IR_Out, mem_rt_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ir_typeMEM_out : INTEGER;

-- MEM/WB buffer
SIGNAL memwb_ir_out , memwb_memdata_out , memwb_aludata_out, memwb_rt_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL memwb_write_to_reg : STD_LOGIC;
SIGNAL ir_typeMEMWB_out : INTEGER;

-- WB
SIGNAL wb_mux_out, wb_ir_out : std_logic_vector (31 downto 0);
SIGNAL ir_typeWB_out : INTEGER;

-- Hazard Detection
SIGNAL stall : std_logic;
-- Forwarding
SIGNAL forwardA , forwardB, forwardC : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL memStageData : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
pc_en <= not stall AND pc_enable;
not_Sel_1 <= not idex_SEL1_out;
--port maps
IFstg : IFStage port map (exmem_Branch_Taken_out,exmem_ALU_out,pc_en,clk,reset,writeInstrData,initializeMem,if_NEXT_PC,if_InstructionValue,stall);
IFIDbuf : IFID_Buffer port map (clk,if_NEXT_PC,stall,if_InstructionValue,ifid_pc_out,ifid_ir_out);
IDstg : ID port map (clk,reset,ifid_ir_out,ifid_pc_out,wb_mux_out,wb_ir_out,memwb_write_to_reg,if_ir_out,if_pc_out,if_rs_data,if_rt_data,if_extend_data,if_sel1,if_sel2,if_ALU_ctrl,if_write_to_reg,if_write_to_mem,if_branch_ctrl,registerRead, register_address,ir_typeWB_out,ir_typeID_out);
IDEXbuf : IDEX_buffer port map (clk,if_pc_out,if_rs_data,if_rt_data,if_extend_data,if_ir_out,if_sel1,if_sel2,if_ALU_ctrl,if_write_to_reg,if_write_to_mem,if_branch_ctrl,idex_pc_out,idex_rs_data_out,idex_rt_data_out,idex_extendData_out,idex_IR_out,idex_SEL1_out,idex_SEL2_out,idex_ALUCtr_out,idex_WriteToReg_out,idex_WriteToMem_out,idex_BranchCtrl_out,ir_typeID_out,ir_typeIDEX_out);
EXstg : EX port map (idex_pc_out,idex_rs_data_out,idex_rt_data_out,idex_extendData_out,idex_IR_out,not_Sel_1,idex_SEL2_out,forwardA,forwardB,forwardC,exmem_ALU_out,memStageData,idex_ALUCtr_out,idex_BranchCtrl_out,ex_ALU_OUT,ex_Branch_Taken,ex_rt_data_OUT,ex_IR_OUT,ir_typeIDEX_out,ir_typeEX_out,exmem_ALU_out,mem_AluDataOut);
EXMEMbuf : EXMEM_buffer port map (clk,ex_Branch_Taken,ex_ALU_OUT,ex_rt_data_OUT,ex_IR_OUT,idex_WriteToReg_out,idex_WriteToMem_out,exmem_WriteToRegOutEXMEM,exmem_WriteToMemOutEXMEM,exmem_Branch_Taken_out,exmem_ALU_out,exmem_rt_data_out,exmem_IR_out,ir_typeEX_out,ir_typeEXMEM_out);
MEMstg : MEM port map (clk,exmem_ALU_out,exmem_rt_data_out,exmem_IR_out,exmem_WriteToMemOutEXMEM,mem_MemoryData,mem_AluDataOut,mem_IR_Out,memoryread,address_data,ir_typeEXMEM_out,ir_typeMEM_out,mem_rt_data_out);
MEMWBbuf : MEMWB_buffer port map (clk,mem_MemoryData,mem_AluDataOut, mem_IR_Out,exmem_WriteToRegOutEXMEM,memwb_memdata_out,memwb_aludata_out,memwb_ir_out,memwb_write_to_reg,ir_typeMEM_out,ir_typeMEMWB_out,mem_rt_data_out,memwb_rt_data_out);
WBstg : WB port map (memwb_memdata_out,memwb_aludata_out, memwb_ir_out,wb_mux_out, wb_ir_out,ir_typeMEMWB_out,ir_typeWB_out);

hazDet : hazard_detection port map (clk,if_InstructionValue,stall);
forw : forwarding port map(exmem_IR_out,memwb_ir_out,idex_IR_out,ir_typeIDEX_out,forwardA,forwardB,forwardC,ir_typeEXMEM_out,ir_typeMEMWB_out);
process(memwb_memdata_out)
BEGIN
	data <=mem_MemoryData ;
END PROCESS;
memStageData <= memwb_memdata_out when (memwb_ir_out(31 downto 26) = "101011" or memwb_ir_out(31 downto 26) = "100011") else memwb_aludata_out;
registerData <= if_rs_data;
end behavioral;
