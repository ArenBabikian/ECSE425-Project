LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Program Counter module
ENTITY pc is
  -- pc must be initialized to 0x0.
PORT( pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
      enable : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END pc;

ARCHITECTURE pc_arch OF pc is
BEGIN

pc_proc : PROCESS(clock,reset)
BEGIN
  IF reset = '1' THEN
    pc_out <= (OTHERS => '0');
  ELSIF clock'EVENT AND clock = '1' AND enable = '1' THEN
    pc_out <= pc_in;
  END IF;
END PROCESS pc_proc;

end pc_arch;
