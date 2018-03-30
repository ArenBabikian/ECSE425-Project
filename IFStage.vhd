LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY IFStage IS
  PORT( SELMUX : IN STD_LOGIC;
      	MUXBRANCHIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      	PCEnable : IN STD_logic;
      	PCClk : IN STD_Logic;
      	PCRESET : IN STD_Logic;
        NEXT_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	      InstructionValue : OUT STD_LOGIC_VECTOR(31 downto 0));
END IFStage;

ARCHITECTURE IF_arch OF IFStage IS

COMPONENT mux is
  PORT( SEL : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT add4 is
  PORT(
	A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	X : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT PC is
  PORT(
	pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	enable : IN STD_LOGIC;
	clock : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

Component InstrMem is
Port(
	progCount : IN std_logic_vector (31 downto 0);
	instrCode : OUT std_logic_vector (31 downto 0)
	);
end component;

SIGNAL add4Out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL pcout : STD_LOGIC_VECTOR(31 downto 0);
signal muxout : STD_Logic_vector (31 downto 0);

BEGIN
fouradder: add4 port map(pcout, add4out);
pcmux: mux port map(SELMUX,MUXBRANCHIN,add4out,muxout);
progcount: pc port map(muxout,PCEnable,PCClk,PCReset,pcout);
InstructionConverter: instrMem port map(pcout, instructionValue);

next_pc <= muxout;


END IF_arch;
