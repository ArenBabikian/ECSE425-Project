--Adapted from Example 12-15 of Quartus Design and Synthesis handbook
--Memory is word addresable
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY memory IS
	GENERIC(
		ram_size : INTEGER := 32768;
		mem_delay : time := 1 ns;
		clock_period : time := 1 ns
	);
	PORT (
		clock: IN STD_LOGIC;
		writedata: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		address: IN INTEGER RANGE 0 TO ram_size-1;
		memwrite: IN STD_LOGIC;
		readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		waitrequest: OUT STD_LOGIC
	);
END memory;

ARCHITECTURE rtl OF memory IS

	TYPE MEM IS ARRAY(ram_size-1 downto 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ram_block: MEM := (others=> (others=>'0'));
	SIGNAL read_address_reg: INTEGER RANGE 0 to ram_size-1;
	SIGNAL write_waitreq_reg: STD_LOGIC := '1';
	SIGNAL read_waitreq_reg: STD_LOGIC := '1';
	signal ram_content : std_logic_vector (31 downto 0);
BEGIN
	--This is the main section of the SRAM model
	mem_process: PROCESS (clock)
	BEGIN
		--This is a cheap trick to initialize the SRAM in simulation

--		IF(now < 1 ps)THEN
	--		For i in 0 to ram_size-1 LOOP
--				ram_block(i) <= std_logic_vector(to_unsigned(i,8));
--			END LOOP;
--		end if;

		--This is the actual synthesizable SRAM block.
		IF (clock'event AND clock = '1' AND address + 3 < 32768 AND address >= 0) THEN
			IF (memwrite = '1') THEN
				ram_block(address) <= writedata(31 downto 24);
        ram_block(address+1) <= writedata(23 downto 16);
        ram_block(address+2) <= writedata(15 downto 8);
        ram_block(address+3) <= writedata(7 downto 0);

			END IF;
		read_address_reg <= address;
		END IF;
	END PROCESS;
	readdata <= ram_block(read_address_reg) & ram_block(read_address_reg+1) & ram_block(read_address_reg+2) & ram_block(read_address_reg+3);
END rtl;
