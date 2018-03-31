LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- 4 to 1 32 bits multiplexer module
ENTITY mux4to1 IS
  PORT( SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        C   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        D   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mux4to1;

ARCHITECTURE mux4to1_arch OF mux4to1 IS
BEGIN
  x <= A WHEN(SEL = "00") ELSE
       B WHEN(SEL = "01") ELSE
       C WHEN(SEL = "10") ELSE
       D;
END mux4to1_arch;
