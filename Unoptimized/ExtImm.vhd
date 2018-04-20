
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ExtImm IS
  PORT( data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        SignExtImm   : IN STD_LOGIC;
        extendData   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ExtImm;

ARCHITECTURE extImm_arch of ExtImm IS

  BEGIN
    PROCESS(data, SignExtImm)
      BEGIN
      IF(SignExtImm = '1') THEN
        extendData <= (31 downto 16 => data(15)) & data(15 DOWNTO 0); --If Sign extend then copy the msb until it is 32 bits long
      ELSE
        extendData <= (31 DOWNTO 16 => '0') & data(15 DOWNTO 0);--Else add 0 until it is 32 bits.
      END IF;
    END PROCESS;
END extImm_arch;
