LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behaviour OF testbench IS

COMPONENT pipeline IS
port (clk : in std_logic;
      a, b, c, d, e : in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk: STD_LOGIC := '0';
SIGNAL s_a, s_b, s_c, s_d, s_e : INTEGER := 0;
SIGNAL s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output : INTEGER := 0;

--components needed for reading from and writing to file
FILE file_input : text;
FILE file_output_reg : text;
FILE file_output_mem : text;
SIGNAL input_command : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL reg_content : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL ram_content : STD_LOGIC_VECTOR (31 downto 0);

CONSTANT clk_period : time := 1 ns;

BEGIN
dut: pipeline
PORT MAP(clk, s_a, s_b, s_c, s_d, s_e, s_op1, s_op2, s_op3, s_op4, s_op5, s_final_output);

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
    VARIABLE reg_cmd : std_logic_vector(31 downto 0);
    VARIABLE mem_cmd : std_logic_vector(31 downto 0);	
	variable ind : integer := 0;

	BEGIN
	--read inputs from file line by line and store the content into the instruction memory
	file_open(file_input, "program.txt", read_mode);
    while not endfile(file_input) loop
        readline(file_input, input_line);
        read(input_line, input_cmd);
		
		
		
		
		
        <= input_cmd;
xxxxx
    end loop;
    file_close(file_input);
	
	
	
	
	wait for 10000 * clk_period;
		
	
	
	--go through the registers array and print its content to a file
	--note that there are 32 registers
	file_open(file_output_reg, "register_file.txt", write_mode);
	while ind < 32 loop	
xxxxx	
		
		<= std_logic_vector(to_unsigned(ind, 'length));
		
		WAIT FOR  1 * clk_period;
		

		reg_content_var := 
		write(reg_line, reg_content_var);
		writeline(file_output_reg, reg_line);		
		ind := ind +1;
	end loop;
	file_close(file_output_reg);

	
	--go through the data memory array and print its content to a file
	--note that there are 32768
	ind := 0;
	file_open(file_output_mem, "memory.txt", write_mode);
	while ind < 32768 loop	
xxxxx	

		<= std_logic_vector(to_unsigned(ind, 'length));
		
		
		WAIT FOR  1 * clk_period;
		
		
		ram_content_var := 
		write(ram_line, ram_content_var);
		writeline(file_output, ram_line);		
		ind := ind +4;
	end loop;
	file_close(file_output_mem);
	
	
	WAIT;
END PROCESS test_process;
END;
