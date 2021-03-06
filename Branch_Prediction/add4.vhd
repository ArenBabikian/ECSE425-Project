LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- ADD4 module
ENTITY add4 IS
PORT( A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      X : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      clock : IN STD_LOGIC);
END add4;

ARCHITECTURE add4_arch OF add4 IS
BEGIN
-- Add 4 to the signal
PROCESS (clock)
  BEGIN
  IF(rising_edge(clock)) THEN
    X <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) + 4, 32)) ;
  END IF;
END PROCESS;
END add4_arch;
