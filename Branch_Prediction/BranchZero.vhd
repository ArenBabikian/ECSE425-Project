LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY BranchZero is
  PORT(
		clock : in std_logic;
    rs_data: in STD_LOGIC_VECTOR (31 downto 0);
    rt_data: in STD_LOGIC_VECTOR (31 downto 0);
    branchCtrl : in STD_LOGIC_VECTOR(1 downto 0);
		prediction : in std_logic;
    BranchTaken : out STD_LOGIC;
		flush_r : out std_logic
  );
END BranchZero;

ARCHITECTURE Behavioral OF BranchZero is
signal btaken : std_logic;
  BEGIN
    PROCESS(clock,branchCtrl)
      BEGIN
      if(rising_edge(clock)) then
      IF(branchCtrl = "00") THEN --J
        btaken <= '1';--When Jumping we are always taking the BranchTaken
      ELSIF(branchCtrl  = "01") THEN -- BEQ
        IF(to_integer(unsigned(rs_data)) - to_integer(unsigned(rt_data)) = 0) THEN
          btaken <= '1'; -- Only jump when equal to each other
        ELSE
          btaken <= '0';
        END IF;
      ELSIF(branchCtrl = "10") THEn --BNEQ
        IF(to_integer(unsigned(rs_data)) - to_integer(unsigned(rt_data)) /= 0) THEN
          btaken <= '1'; -- Only jump when not equal to each other
        ELSE
          btaken <= '0';
        END IF;
      ELSE
      	btaken <= '0';
      END IF;
    end if;
    END PROCESS;
    PROCESS(clock,btaken)
    BEGIN
    	IF(rising_edge(clock)) then
    		IF(prediction = btaken) THEN
    			flush_r <= '0';
    		ELSE
    			flush_r <= '1';
    		END IF;
    	END IF;
    END PROCESS;
  branchTaken <= btaken;
END Behavioral;
