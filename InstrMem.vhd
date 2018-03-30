LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY InstrMem is
PORT (
	progCount : IN std_logic_vector (31 downto 0);
	instrCode : OUT std_logic_vector (31 downto 0)
	);
END InstrMem;

ARCHITECTURE behavioral OF InstrMem is

  FILE file_input : text;
  CONSTANT command_size : natural := 32;
  SIGNAL input_command : STD_LOGIC_VECTOR (command_size-1 downto 0);

BEGIN
  PROCESS
    VARIABLE input_line : line;
    VARIABLE input_cmd : std_logic_vector(command_size-1 downto 0);
	variable cur_line : integer:= 0;
	variable trgt_line : integer;

    BEGIN
	instrCode <= (OTHERS => '0');
	file_open(file_input, "program.txt", read_mode);
	trgt_line := to_integer(signed(progCount));
	while not endfile(file_input) and cur_line <= trgt_line loop
    		readline(file_input, input_line);
		if cur_line = trgt_line then
			read(input_line, input_cmd);
			instrCode <= input_cmd;
		end if;
		cur_line := cur_line +1;
	end loop;
	file_close(file_input);

  END PROCESS;

END ARCHITECTURE;