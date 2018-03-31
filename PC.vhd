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
      next_pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END pc;

ARCHITECTURE pc_arch OF pc is
  SIGNAL pc_count : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";

BEGIN
pc_proc : PROCESS(clock,reset,enable)
BEGIN
  IF reset = '1' THEN
    pc_count <= (OTHERS => '0');
  ELSIF rising_edge(clock) THEN
    IF(enable = '1') THEN
    IF(pc_sel = '0') THEN
      pc_count <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_count)) + 4, 32)) ;
    ELSE
      pc_count <= jump_in;
    END IF;
    END IF;
  END IF;

  IF(pc_sel = '0') THEN
    next_pc_out <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_count)) + 4, 32)) ;
  ELSE
    next_pc_out <= jump_in;
  END IF;

END PROCESS pc_proc;

pc_out <= pc_count;

end pc_arch;
