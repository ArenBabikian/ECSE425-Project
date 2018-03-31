LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Memory stage
ENTITY MEM IS
generic(
	ram_size : INTEGER := 32768
);
  PORT( clock : IN STD_LOGIC;
				AluData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				WriteDataMem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				mem_en : IN STD_LOGIC;
				MemoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				AluDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				IR_Out : OUT STD_LOGIC_VECTOR(31 downto 0);

				readmemory : in std_logic;
				data_address : in std_logic_vector(31 DOWNTO 0));
END MEM;

ARCHITECTURE MEM_arch OF MEM IS
--COMPONENTS AND SIGNALS
COMPONENT memory IS
  PORT( clock: IN STD_LOGIC;
    writedata: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    address: IN INTEGER RANGE 0 TO ram_size-1;
    memwrite: IN STD_LOGIC;
    readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    waitrequest: OUT STD_LOGIC);
END COMPONENT;

SIGNAL AluDataSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL memAddress : INTEGER RANGE 0 TO ram_size-1;
SIGNAL TempSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
--LOGIC:
--this stage only contains a data memory component
mem1: memory port map(clock,WriteDataMem,memAddress,mem_en,MemoryData, OPEN);

--the process below allows for reading from the registers (used to possibly print out the final contents of the registers 
--after the completion of a program
  PROCESS (AluData)
    BEGIN
		if readmemory = '0' then
			memAddress <= to_integer(unsigned(AluData(14 downto 0)));
		else
			memAddress <= to_integer(unsigned(data_address));
		end if;
	IR_Out <= IR;
  END PROCESS;
	AluDataOut <= AluData;
END MEM_arch;
