LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY InstrMem is
GENERIC(
	ram_size : INTEGER := 32768);
PORT (
	clock : IN std_logic;
	progCount : IN std_logic_vector (31 downto 0);
	WriteDataMem: IN std_logic_vector(31 downto 0);
	initializeMem : IN std_logic;
	instrCode : OUT std_logic_vector (31 downto 0));
END InstrMem;

ARCHITECTURE behavioral OF InstrMem is

  SIGNAL data : STD_LOGIC_VECTOR (31 downto 0);

	COMPONENT memory IS
	  PORT( clock: IN STD_LOGIC;
	    writedata: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	    address: IN INTEGER RANGE 0 TO ram_size-1;
	    memwrite: IN STD_LOGIC;
	    readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
	    waitrequest: OUT STD_LOGIC);
	END COMPONENT;
	SIGNAL progCount_int : INTEGER RANGE 0 TO ram_size-1;
BEGIN
mem1: memory port map(clock,WriteDataMem,progCount_int,initializeMem,data, OPEN);

  PROCESS(progCount,initializeMem)
	BEGIN
		if((unsigned(progCount) < 32768)) then
			progCount_int <= to_integer(unsigned(progCount));
		else
			progCount_int <= 32767;
		END IF;
		IF(initializeMem = '0') THEN
			instrCode <= data;
		ELSE
			instrCode <= "00000000000000000000000000100000";
		END IF;
  END PROCESS;
END ARCHITECTURE;
