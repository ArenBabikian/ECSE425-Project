LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behaviour OF testbench IS

COMPONENT pipeline IS
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
	registerData : out std_logic_vector(31 DOWNTO 0)
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, reset, initMem, memread, regread: STD_LOGIC := '0';
SIGNAL writeInstrData, addr_data, data, regdata : std_logic_vector(31 downto 0) := (others => '0') ;
SIGNAL reg_addr : std_logic_vector(4 downto 0);
--components needed for reading from and writing to file
FILE file_input : text;
FILE file_output_reg : text;
FILE file_output_ram : text;
SIGNAL input_command : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL reg_content : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL ram_content : STD_LOGIC_VECTOR (31 downto 0);

CONSTANT clk_period : time := 2 ns;

BEGIN
dut: pipeline
PORT MAP(clk, reset, initMem, writeInstrData, memread, addr_data, data, regread, reg_addr, regdata);

 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;


test_process: PROCESS
	--variables needed for read and write operations

	VARIABLE input_line : line;
	VARIABLE reg_line : line;
	VARIABLE ram_line : line;
    VARIABLE input_cmd : std_logic_vector(31 downto 0);
    VARIABLE reg_content_var : std_logic_vector(31 downto 0);
    VARIABLE ram_content_var : std_logic_vector(31 downto 0);
	variable ind : integer := 0;

	BEGIN
		report "report1";
		reset <= '1';
		regread <= '0';

		wait for 1*clk_period;

		reset <= '0';
	--read inputs from file line by line and store the content into the instruction memory
	--setting initmem to 1 allows to write to the intruction memory
	initMem <= '1';
	file_open(file_input, "program.txt", read_mode);
		report "report2";
    while not endfile(file_input) loop
		report "initialization step";
        readline(file_input, input_line);
        read(input_line, input_cmd);

		writeInstrData <= input_cmd;

		wait for 1 * clk_period;
		--at every clock cycle, the PC is incremented by 4, thus every time we
		--write something to memory, we writ it in the following position

    end loop;
    file_close(file_input);

	report "initialization done";
	writeInstrData <= "00000000000000000000000000000000";
	reset <= '1';

	wait for 1*clk_period;
	initmem <= '0';

	reset <= '0';

	wait for 10000 * clk_period;


	report "waiting done";
	--go through the registers array and print its content to a file
	--note that there are 32 registers
	regread <= '1';
	file_open(file_output_reg, "register_file.txt", write_mode);
	while ind < 32 loop

		reg_addr <= std_logic_vector(to_unsigned(ind, reg_addr'length));
		WAIT FOR  1 * clk_period;

		reg_content_var := regdata;
		write(reg_line, reg_content_var);
		writeline(file_output_reg, reg_line);
		ind := ind +1;
	end loop;
	file_close(file_output_reg);

	regread <= '0';
	reg_addr <= "00000";

	report "writing registers done";

	--go through the data memory array and print its content to a file
	--note that there are 32768
	ind := 0;
	memread <= '1';
	file_open(file_output_ram, "memory.txt", write_mode);
	while ind < 32767 loop

		addr_data <= std_logic_vector(to_unsigned(ind, addr_data'length));
		WAIT FOR  1 * clk_period;


		ram_content_var := data;
		write(ram_line, ram_content_var);
		writeline(file_output_ram, ram_line);
		ind := ind +4;
	end loop;
	file_close(file_output_ram);

	memread <= '0';
	data <= "00000000000000000000000000000000";

	report "writing memory done";
	WAIT;
END PROCESS test_process;
END;
