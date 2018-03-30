LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY Registers is
  PORT(
    clock : in STD_LOGIC;
    rs : in STD_LOGIC_VECTOR (4 DOWNTO 0);
    rt : in STD_LOGIC_VECTOR (4 DOWNTO 0);
    rd : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
    rd_data : in STD_LOGIC_VECTOR (31 DOWNTO 0);
    write_enable : in STD_LOGIC;
    reset : in STD_LOGIC;
    rs_data : out STD_LOGIC_VECTOR (31 DOWNTO 0);
    rt_data : out STD_LOGIC_VECTOR (31 downto 0)
  );
END Registers;

ARCHITECTURE Behavioral OF Registers is


	TYPE registers_type is ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL registers_array : registers_type := (OTHERS => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)));
	signal reg_content : std_logic_vector(31 downto 0);
  
  BEGIN
  registering : PROCESS (clock, reset)
    BEGIN

    IF(reset = '1') THEN
      registers_array <= (OTHERS => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)));
    ELSIF(clock'event) THEN
      rs_data <= registers_array(TO_INTEGER(UNSIGNED(rs)));
      rt_data <= registers_array(TO_INTEGER(UNSIGNED(rt)));

      IF(write_enable = '1' AND TO_INTEGER(UNSIGNED(rd)) /= 0) THEN --Ensures that R0 is never writen too.
        registers_array(TO_INTEGER(UNSIGNED(rd))) <= rd_data;
      END IF;
    END IF;
  END PROCESS;
  
  	--printing after the end of the program
	printing : process (clock)
	FILE file_output : text;
	VARIABLE output_line : line;
    VARIABLE reg_content_var : std_logic_vector(31 downto 0);
	variable ind : integer := 0;

    BEGIN
		while ind < 10000 loop
			if(clock'EVENT and clock = '1') then
				ind := ind + 1;
			end if;
		end loop;
		
		ind := 0;
		file_open(file_output, "register_file.txt", write_mode);
		while ind < 32 loop	
			reg_content <= registers_array(ind);
			reg_content_var := reg_content;
			write(output_line, reg_content_var);
			writeline(file_output, output_line);		
			ind := ind +1;
		end loop;
		file_close(file_output);
	end process;

END Behavioral;
