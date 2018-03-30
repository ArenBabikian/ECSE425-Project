LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY hazard_detection is
  PORT( IDEX_REGISTER : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        IFID_rs : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        IFID_rt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        STALL_REQUEST : OUT STD_LOGIC);
END hazard_detection;

ARCHITECTURE hazard_detection_arch of hazard_detection is
BEGIN
  STALL_REQUEST <= '1' WHEN (IDEX_REGISTER = IFID_rs or IDEX_REGISTER = IFID_rd)
                       ELSE '0';
END hazard_detection_arch;
