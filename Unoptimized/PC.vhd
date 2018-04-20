LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Program Counter module
ENTITY pc is
  -- pc must be initialized to 0x0.
PORT( enable : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      pc_sel: IN STD_logic;
      jump_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      next_pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      stall : IN STD_LOGIC);
END pc;

ARCHITECTURE pc_arch OF pc is
  SIGNAL pc_count : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
  TYPE State_type IS (stalled,notStalled);
  Signal state: State_type;
BEGIN
pc_proc : PROCESS(clock,reset,enable,stall)
BEGIN
  IF reset = '1' THEN
    pc_count <= (OTHERS => '0');
    state <= notStalled;
  ELSIF enable = '1'THEN
    IF(rising_edge(clock)) THEN
    IF(pc_sel = '0') THEN
      pc_count <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_count)) + 4, 32)) ;
    END IF;
    END IF;
  END IF;
  IF(pc_sel = '1') THEN
    pc_count <= std_logic_vector(to_unsigned(to_integer(unsigned(jump_in)) + 4, 32)) ;
  END IF;
 if(stall'event AND stall = '1') THEN
          pc_count <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_count)) - 4, 32)) ;
  END IF;
  IF(pc_sel = '0') THEN
    next_pc_out <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_count)) + 8, 32)) ;
  ELSE
    next_pc_out <= std_logic_vector(to_unsigned(to_integer(unsigned(jump_in)) + 8, 32)) ;
  END IF;

END PROCESS pc_proc;



pc_out <= STD_LOGIC_VECTOR(unsigned(pc_count) + 4);


end pc_arch;
