LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Instruction fetch stage
ENTITY IFStage IS
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
END IFStage;

ARCHITECTURE IF_arch OF IFStage IS

COMPONENT PC is
  PORT( enable : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      pc_sel: IN STD_logic;
      jump_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      next_pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      stall : IN STD_LOGIC);
END COMPONENT;

Component InstrMem is
  PORT (
  	clock : IN std_logic;
  	progCount : IN std_logic_vector (31 downto 0);
  	WriteDataMem: IN std_logic_vector(31 downto 0);
  	initializeMem : IN std_logic;
  	instrCode : OUT std_logic_vector (31 downto 0)
  	);
end component;

SIGNAL add4Out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL pcout : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL irout : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal muxout : STD_Logic_vector (31 downto 0);

BEGIN
progcount: pc port map(PCEnable,PCClk,PCReset,SELMUX,MUXBRANCHIN,pcout,muxout,stall);
InstructionConverter: instrMem port map(PCClk,pcout,writeInstrData,initializeMem, irout);
InstructionValue <= irout;
next_pc <= muxout;


END IF_arch;
