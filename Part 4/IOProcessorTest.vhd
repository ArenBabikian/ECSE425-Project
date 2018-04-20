LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY processor is
 
END processor;

ARCHITECTURE behavioral OF processor is

  FILE file_input : text;
  FILE file_output : text;
  CONSTANT command_size : natural := 32;
  SIGNAL input_command : STD_LOGIC_VECTOR (command_size-1 downto 0);
  SIGNAL output_command : std_logic_vector(command_size-1 downto 0);

BEGIN
  PROCESS
    VARIABLE input_line : line;
    VARIABLE input_cmd : std_logic_vector(command_size-1 downto 0);
    VARIABLE output_cmd : std_logic_vector(command_size-1 downto 0);
    VARIABLE output_line : line;

    BEGIN
      file_open(file_input, "program.txt", read_mode);
      file_open(file_output, "memory.txt", write_mode);

      while not endfile(file_input) loop
        readline(file_input, input_line);
        read(input_line, input_cmd);

        input_command <= input_cmd;
        output_command <= input_command;
        --output_cmd <= output_command;

        write(output_line, output_command);
        writeline(file_output, output_line);
      end loop;

      file_close(file_input);
      file_close(file_output);
  END PROCESS;

END ARCHITECTURE;