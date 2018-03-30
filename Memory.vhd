--Adapted from Example 12-15 of Quartus Design and Synthesis handbook
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
		memread: IN STD_LOGIC;
		readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		waitrequest: OUT STD_LOGIC
	);
END memory;

ARCHITECTURE rtl OF memory IS
	
	TYPE MEM IS ARRAY(ram_size-1 downto 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ram_block: MEM;
	SIGNAL read_address_reg: INTEGER RANGE 0 to ram_size-1;
	SIGNAL write_waitreq_reg: STD_LOGIC := '1';
	SIGNAL read_waitreq_reg: STD_LOGIC := '1';
	signal ram_content : std_logic_vector (31 downto 0);
BEGIN
	--This is the main section of the SRAM model
	mem_process: PROCESS (clock)
	BEGIN
		--This is a cheap trick to initialize the SRAM in simulation
		IF(now < 1 ps)THEN
			For i in 0 to ram_size-1 LOOP
				ram_block(i) <= std_logic_vector(to_unsigned(i,8));
			END LOOP;
		end if;

		--This is the actual synthesizable SRAM block
		IF (clock'event AND clock = '1' AND address rem 32 = 0) THEN
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


	--The waitrequest signal is used to vary response time in simulation
	--Read and write should never happen at the same time.
	waitreq_w_proc: PROCESS (memwrite)
	BEGIN
		IF(memwrite'event AND memwrite = '1')THEN
			write_waitreq_reg <= '0' after clock_period, '1' after clock_period + clock_period;

		END IF;
	END PROCESS;

	waitreq_r_proc: PROCESS (memread)
	BEGIN
		IF(memread'event AND memread = '1')THEN
			read_waitreq_reg <= '0' after clock_period, '1' after clock_period + clock_period;
		END IF;
	END PROCESS;
	waitrequest <= write_waitreq_reg and read_waitreq_reg;
	
	--printing after the end of the program
	printing : process (clock)
	FILE file_output : text;
	VARIABLE output_line : line;
    VARIABLE ram_content_var : std_logic_vector(31 downto 0);
	variable ind : integer := 0;

    BEGIN
		while ind < 10000 loop
			if(clock'EVENT and clock = '1') then
				ind := ind + 1;
			end if;
		end loop;
		
		ind := 0;
		file_open(file_output, "memory.txt", write_mode);
		while ind < ram_size-1 loop	
			ram_content(31 downto 24) <= ram_block(ind);
			ram_content(23 downto 16) <= ram_block(ind+1);
			ram_content(15 downto 8) <= ram_block(ind+2);
			ram_content(7 downto 0) <= ram_block(ind+3) ;
			ram_content_var := ram_content;
			write(output_line, ram_content_var);
			writeline(file_output, output_line);		
			ind := ind +4;
		end loop;
		file_close(file_output);
	end process;

END rtl;
