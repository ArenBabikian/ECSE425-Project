LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Hazard Detection module
ENTITY hazard_detection is
  PORT( idex_IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rs : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        rt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        STALL_REQUEST : OUT STD_LOGIC);
END hazard_detection;

ARCHITECTURE hazard_detection_arch of hazard_detection is
SIGNAL R : STD_LOGIC;
SIGNAL rd : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
  rd <= idex_IR(15 DOWNTO 11);
  -- checks if it is a R instruction
  R <= '1' WHEN(idex_IR(31 DOWNTO 26)="000000") ELSE '0';
  -- If R instruction, hazard occurs if rd is the same as rs or rt
  -- rd /= "00000" is required to make sure a stall does not create another stall
  STALL_REQUEST <= '1' WHEN ((rd = rs or rd = rt) AND R='1' AND rd /= "00000")
                       ELSE '0';
END hazard_detection_arch;
