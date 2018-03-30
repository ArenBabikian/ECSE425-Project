LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY BranchZero is
  PORT(
    rs: in STD_LOGIC_VECTOR (31 downto 0);
    rt: in STD_LOGIC_VECTOR (31 downto 0);
    branchCtrl : in STD_LOGIC_VECTOR(1 downto 0);
    BranchTaken : out STD_LOGIC
  );
END BranchZero;

ARCHITECTURE Behavioral OF BranchZero is

  BEGIN
    PROCESS(rs,rt,branchCtrl)
      BEGIN
      IF(branchCtrl = "00") THEN --j
        BranchTaken <= '1';
      ELSIF(branchCtrl  = "01") THEN -- BEQ
        IF(to_integer(unsigned(rs)) - to_integer(unsigned(rt)) = 0) THEN
          BranchTaken <= '1';
        ELSE
          BranchTaken <= '0';
        END IF;
      ELSIF(branchCtrl = "10") THEn --BNEQ
        IF(to_integer(unsigned(rs)) - to_integer(unsigned(rt)) /= 0) THEN
          BranchTaken <= '1';
        ELSE
          BranchTaken <= '0';
        END IF;
      ELSE
      	BranchTaken <= '0';
      END IF;
    END PROCESS;
END Behavioral;
