library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (
	clk : in std_logic;
	reset : in std_logic;
  );
end pipeline;

architecture behavioral of pipeline is

	--BUFFER COMPONENTS
	Component IFID_buffer is
		PORT( 
			clock : IN STD_LOGIC;
			pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			stall_request : IN STD_LOGIC;
			IR : IN STD_LOGIC_VECTOR(0 TO 31);
			
			pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		);
	END component;

	Component IDEX_buffer is
		PORT( 

		);
	END component;

	Component EXMEM_buffer is
		PORT( 
			clock : IN STD_LOGIC;
			Branch_Taken_in : IN STD_LOGIC;
			ALU_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		   
			Branch_Taken_out : OUT STD_LOGIC;
			ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
		);
	END component;

	Component MEMWB_buffer is
		PORT( 
			clock : IN STD_LOGIC;
			memdata_in : IN std_logic_vector (31 downto 0);
			aludata_in : IN std_logic_vector (31 downto 0);
			temp_in : IN std_logic_vector (31 downto 0);
			
			memdata_out : out std_logic_vector (31 downto 0);
			aludata_out : out std_logic_vector (31 downto 0);
			temp_out : out std_logic_vector (31 downto 0)
		);
	END component;
	
	--STAGE COMPONENTS
	Component IFStage is
		PORT( 
			SELMUX : IN STD_LOGIC;
			MUXBRANCHIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			PCEnable : IN STD_logic;
			PCClk : IN STD_Logic;
			PCRESET : IN STD_Logic;
			
		    NEXT_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			InstructionValue : OUT STD_LOGIC_VECTOR(31 downto 0);
		);
	END component;

	Component ID is
		PORT( 

		);
	END component;

	Component EX is
		PORT( 
			ONE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			TWO : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			FOUR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SEL1 : IN STD_LOGIC;
			SEL2 : IN STD_LOGIC;
			ALUCtr1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Branch_Taken :  OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	End Component;

	Component MEM is
		PORT( 
			clock : IN STD_LOGIC;
			AluData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			WriteDataMem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Temp : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_en : IN STD_LOGIC;
			SEL2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
			
			MemoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AluDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Temp_Out : OUT STD_LOGIC;
		);
	END component;

	Component WB is
		PORT( 
			mux_sel : IN std_logic;
			mem_in : IN std_logic_vector (31 downto 0);
			alu_in  : IN std_logic_vector (31 downto 0);
			temp_in : IN std_logic_vector (31 downto 0);
			
			mux_out : out std_logic_vector (31 downto 0);
			temp_out : out std_logic_vector (31 downto 0)
		);
	END component;
	
	--Hazard Detection
	component hazard_detection is
		PORT(
			IDEX_REGISTER : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			IFID_REGISTER1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			IFID_REGISTER2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			STALL_REQUEST : OUT STD_LOGIC)
		);
	end component;
	


-- test signals
	SIGNAL reset : std_logic := '0';
	SIGNAL clk : std_logic := '0';
	CONSTANT clk_period : TIME := 2 ns;

	SIGNAL s_addr : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_read : std_logic;
	SIGNAL s_readdata : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_write : std_logic;
	SIGNAL s_writedata : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_waitrequest : std_logic;

	SIGNAL m_addr : INTEGER RANGE 0 TO 2147483647;
	SIGNAL m_read : std_logic;
	SIGNAL m_readdata : std_logic_vector (7 DOWNTO 0);
	SIGNAL m_write : std_logic;
	SIGNAL m_writedata : std_logic_vector (7 DOWNTO 0);
	SIGNAL m_waitrequest : std_logic;





--Temporary variables
--signal index : std_logic_vector(5 downto 0) := "00001";

--hazard detection	
signal hazdet_stallreq : std_logic;
--if stage
signal if_next_pc, if_instr_val : std_logic_vector(31 downto 0);
--ifid buffer
signal ifid_pc_out, ifid_ir_out :std_logic_vector(31 downto 0);
--id stage

--idex buffer

--ex stage
signal 
--exmem buffer
signal exmem_branch_taken : std_logic;
signal exmem_alu_out, exmem_three_out, exmem_five_out : std_logic_vector(31 downto 0);
--mem stage
signal mem_data_out, mem_alu_out, mem_tmp_out : std_logic_vector(31 downto 0);
--memwb buffer
signal  memwb_data_out, memwb_alu_out, memwb_tmp_out : std_logic_vector(31 downto 0);
--wb stage
signal wb_mux_out, wb_temp_out : std_logic_vector(31 downto 0);

begin

process (clk)
begin

--port maps
IFstg : IFStage port map (exmem_branch_taken,exmem_alu_out,not hazdet_stallreq,clk,reset,if_next_pc,if_instr_val);
IFIDbuf : IFID_Buffer port map (clk,if_next_pc,hazdet_stallreq,if_instr_val,ifid_pc_out,ifid_ir_out);
IDstg : ID port map ( );
IDEXbuf : IDEX_buffer port map ( );
EXstg : EX port map ( );
EXMEMbuf : EXMEM_buffer port map (clk,,,,,exmem_branch_taken,exmem_alu_out,exmem_three_out,exmem_five_out);
MEMstg : MEM port map (clk,exmem_alu_out,exmem_three_out,exmem_five_out,,,mem_data_out,mem_alu_out,mem_tmp_out);
MEMWBbuf : MEMWB_buffer port map (clk,mem_data_out,mem_alu_out,mem_tmp_out,memwb_data_out,memwb_alu_out,memwb_tmp_out);
WBstg : WB port map (,memwb_data_out,memwb_alu_out,memwb_tmp_out,wb_mux_out, wb_temp_out);

hazDet : hazard_detection port map (

--Pipeline
/*

if (clk'event and clk = '1') then
--STAGE 5
if (index(4) = '1') then
-------------
-------------
	index(4) <= '0';
end if;
--STAGE 4
if (index(3) = '1') then
---------------
---------------
	index(4) <= '1';
	index(3) <= '0';
end if;
--STAGE 3
if (index(2) = '1') then
---------------
---------------
	index(3) <= '1';
	index(2) <= '0';
end if;
--STAGE 2
if (index(1) = '1') then
---------------
---------------
	index(2) <= '1';
	index(1) <= '0';
end if;
--STAGE 1
if (index(0) = '1') then
---------------
---------------
	index(1) <= '1';
end if;

end if;
*/
end process;

end behavioral;