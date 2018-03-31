LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- forwarding module
ENTITY forwarding IS
PORT( exmem_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      memwb_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rs : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      rt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      forward_A : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forward_B : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END forwarding;

ARCHITECTURE forwarding_arch OF forwarding IS

SIGNAL exmem_rd , memwb_rd: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL R_memwb , R_exmem : STD_LOGIC;

BEGIN
exmem_rd <= exmem_ir(25 DOWNTO 21);
memwb_rd <= memwb_ir(20 DOWNTO 16);
R_exmem <= '1' WHEN(exmem_ir(31 DOWNTO 26)="000000") ELSE '0';
R_memwb <= '1' WHEN(memwb_ir(31 DOWNTO 26)="000000") ELSE '0';

forward_A <= "10" WHEN(exmem_rd /= "00000" and exmem_rd = rs and R_exmem = '1') ELSE
             "01" WHEN(memwb_rd /= "00000" and memwb_rd = rs and R_memwb = '1') ELSE
             "00";

forward_B <= "10" WHEN(exmem_rd /= "00000" and exmem_rd = rt and R_exmem = '1') ELSE
             "01" WHEN(memwb_rd /= "00000" and memwb_rd = rt and R_memwb = '1') ELSE
             "00";

END forwarding_arch;
