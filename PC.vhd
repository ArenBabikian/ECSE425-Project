LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pc is
PORT( pc_in : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
      enable : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      pc_out : OUT STD_LOGIC_VECTOR(32 DOWNTO 0));
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
