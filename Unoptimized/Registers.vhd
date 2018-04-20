LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY Registers is
GENERIC(
		register_size: INTEGER := 32 --MIPS register size is 32 bit
	);
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


	TYPE registers_type is ARRAY (0 to 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL registers_array : registers_type := (OTHERS => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)));
	signal reg_content : std_logic_vector(31 downto 0);
  signal rs_content : INTEGER := 0;
  signal rt_content : INTEGER := 0;

  BEGIN
  rs_content <= to_integer(unsigned(rs));
  rt_content <= to_integer(unsigned(rt));
  PROCESS (clock,reset,rs,rt)
    BEGIN
           
    IF (clock'event) THEN
			 rs_data <= registers_array(to_integer(unsigned(rs))); -- fetch data immediately from rs index
            rt_data <= registers_array(to_integer(unsigned(rt))); -- fetch data immediately from rt index
      IF(write_enable = '1' AND TO_INTEGER(UNSIGNED(rd)) /= 0) THEN --Ensures that R0 is never writen too.
        registers_array(TO_INTEGER(UNSIGNED(rd))) <= rd_data;
      END IF;
      if(rd = rs AND rd /= "00000") then
              rs_data <= rd_data;
            end if;
            if(rd = rt AND rd /= "00000") then 
              rt_data <= rd_data;
            end if;
    END IF;
    
  END PROCESS;

  

      

END Behavioral;
