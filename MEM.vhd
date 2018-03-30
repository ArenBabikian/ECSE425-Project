LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MEM IS
generic(
	ram_size : INTEGER := 32768
);
-- ONE,TWO,THREE,THREE_OUT,FOUR,FIVE,SEL1,SEL2 are placeholder names
  PORT(
		clock : IN STD_LOGIC;
		AluData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteDataMem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Temp : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		mem_en : IN STD_LOGIC;
		MemoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		AluDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Temp_Out : OUT STD_LOGIC_VECTOR(31 downto 0)
		);

END MEM;

ARCHITECTURE MEM_arch OF MEM IS

COMPONENT memory IS
  PORT( clock: IN STD_LOGIC;
    writedata: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    address: IN INTEGER RANGE 0 TO ram_size-1;
    memwrite: IN STD_LOGIC;
    memread: IN STD_LOGIC;
    readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    waitrequest: OUT STD_LOGIC);
END COMPONENT;

SIGNAL AluDataSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL memAddress : INTEGER;
SIGNAL TempSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL emptySignal : STD_LOGIC := '0';

BEGIN
mem1: memory port map(clock,WriteDataMem,memAddress,mem_en,emptySignal,MemoryData, OPEN);

  PROCESS (AluData)
    BEGIN
	memAddress <= to_integer(unsigned(AluData));
	Temp_Out <= Temp;
  END PROCESS;

END MEM_arch;
