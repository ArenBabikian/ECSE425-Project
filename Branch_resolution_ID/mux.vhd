LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- 2 to 1 32 bits multiplexer module
ENTITY mux IS
  PORT( SEL : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mux;

ARCHITECTURE mux_arch OF mux IS
BEGIN
  x <= A WHEN (SEL = '1') ELSE B;
END mux_arch;
