LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Hazard Detection module
ENTITY hazard_detection is
  PORT( clock : IN STD_LOGIC;
        ifid_IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        STALL_REQUEST : OUT STD_LOGIC);
END hazard_detection;

ARCHITECTURE hazard_detection_arch of hazard_detection is
SIGNAL instruction1 : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
SIGNAL instruction2 : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
SIGNAL instruction3 : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
SIGNAL instruction4 : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
SIGNAL ifid_IR_type,instruction1_type, instruction2_type, instruction3_type, instruction4_type : INTEGER;
SIGNAL write1,write2,write3,write4, op1_addr, op2_addr : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL op1_hazard, op2_hazard, branch_hazard, structural_hazard : STD_LOGIC;
BEGIN
  instruction1_type <= 0 WHEN (instruction1(31 DOWNTO 26) = "000000") 
                         else 1 WHEN
                         instruction1(31 DOWNTO 26) = "001000" or
                         instruction1(31 DOWNTO 26) = "001010" or
                         instruction1(31 DOWNTO 26) = "001100" or
                         instruction1(31 DOWNTO 26) = "001101" or
                         instruction1(31 DOWNTO 26) = "001110" or
                         instruction1(31 DOWNTO 26) = "001111" or
                         instruction1(31 DOWNTO 26) = "100011" or
                         instruction1(31 DOWNTO 26) = "101011" or
                         instruction1(31 DOWNTO 26) = "000100" or
                         instruction1(31 DOWNTO 26) = "000101" 
                         else 2 WHEN
                         instruction1(31 DOWNTO 26) = "000010" or
                         instruction1(31 DOWNTO 26) = "000011"
                         else 3;

    instruction2_type <= 0 WHEN (instruction2(31 DOWNTO 26) = "000000") 
                         else 1 WHEN
                         instruction2(31 DOWNTO 26) = "001000" or
                         instruction2(31 DOWNTO 26) = "001010" or
                         instruction2(31 DOWNTO 26) = "001100" or
                         instruction2(31 DOWNTO 26) = "001101" or
                         instruction2(31 DOWNTO 26) = "001110" or
                         instruction2(31 DOWNTO 26) = "001111" or
                         instruction2(31 DOWNTO 26) = "100011" or
                         instruction2(31 DOWNTO 26) = "101011" or
                         instruction2(31 DOWNTO 26) = "000100" or
                         instruction2(31 DOWNTO 26) = "000101" 
                         else 2 WHEN
                         instruction2(31 DOWNTO 26) = "000010" or
                         instruction2(31 DOWNTO 26) = "000011"
                         else 3;

    instruction3_type <= 0 WHEN (instruction3(31 DOWNTO 26) = "000000") 
                         else 1 WHEN
                         instruction3(31 DOWNTO 26) = "001000" or
                         instruction3(31 DOWNTO 26) = "001010" or
                         instruction3(31 DOWNTO 26) = "001100" or
                         instruction3(31 DOWNTO 26) = "001101" or
                         instruction3(31 DOWNTO 26) = "001110" or
                         instruction3(31 DOWNTO 26) = "001111" or
                         instruction3(31 DOWNTO 26) = "100011" or
                         instruction3(31 DOWNTO 26) = "101011" or
                         instruction3(31 DOWNTO 26) = "000100" or
                         instruction3(31 DOWNTO 26) = "000101" 
                         else 2 WHEN
                         instruction3(31 DOWNTO 26) = "000010" or
                         instruction3(31 DOWNTO 26) = "000011"
                         else 3;

      instruction4_type <= 0 WHEN (instruction4(31 DOWNTO 26) = "000000") 
                         else 1 WHEN
                         instruction4(31 DOWNTO 26) = "001000" or
                         instruction4(31 DOWNTO 26) = "001010" or
                         instruction4(31 DOWNTO 26) = "001100" or
                         instruction4(31 DOWNTO 26) = "001101" or
                         instruction4(31 DOWNTO 26) = "001110" or
                         instruction4(31 DOWNTO 26) = "001111" or
                         instruction4(31 DOWNTO 26) = "100011" or
                         instruction4(31 DOWNTO 26) = "101011" or
                         instruction4(31 DOWNTO 26) = "000100" or
                         instruction4(31 DOWNTO 26) = "000101" 
                         else 2 WHEN
                         instruction4(31 DOWNTO 26) = "000010" or
                         instruction4(31 DOWNTO 26) = "000011"
                         else 3;  

    ifid_IR_type <= 0 WHEN (ifid_IR(31 DOWNTO 26) = "000000") 
                         else 1 WHEN
                         ifid_IR(31 DOWNTO 26) = "001000" or
                         ifid_IR(31 DOWNTO 26) = "001010" or
                         ifid_IR(31 DOWNTO 26) = "001100" or
                         ifid_IR(31 DOWNTO 26) = "001101" or
                         ifid_IR(31 DOWNTO 26) = "001110" or
                         ifid_IR(31 DOWNTO 26) = "001111" or
                         ifid_IR(31 DOWNTO 26) = "100011" or
                         ifid_IR(31 DOWNTO 26) = "101011" or
                         ifid_IR(31 DOWNTO 26) = "000100" or
                         ifid_IR(31 DOWNTO 26) = "000101" 
                         else 2 WHEN
                         ifid_IR(31 DOWNTO 26) = "000010" or
                         ifid_IR(31 DOWNTO 26) = "000011"
                         else 3;   

  write1 <= instruction1(15 DOWNTO 11) when instruction1_type = 0
            else instruction1(20 DOWNTO 16) when instruction1_type = 1
            else "00000";

     write2 <= instruction2(15 DOWNTO 11) when instruction2_type = 0
            else instruction2(20 DOWNTO 16) when instruction2_type = 1
            else "00000";
    write3 <= instruction3(15 DOWNTO 11) when instruction3_type = 0
            else instruction3(20 DOWNTO 16) when instruction3_type = 1
            else "00000";
  write4 <= instruction4(15 DOWNTO 11) when instruction4_type = 0
    else instruction4(20 DOWNTO 16) when instruction4_type = 1
    else "00000";
  op1_addr <= ifid_IR(25 DOWNTO 21) when ifid_IR_type = 0 or ifid_IR_type = 1
              else "00000";
   op2_addr <= ifid_IR(20 DOWNTO 16) when ifid_IR_type = 0 or ifid_IR(31 downto 26) = "101011"
              else "00000";

  op1_hazard <= '1' when op1_addr /= "00000" AND (op1_addr = write1 AND instruction1(31 DOWNTO 0) = "100011") else '0';

  op2_hazard <= '1' when op2_addr /= "00000" AND (op2_addr = write1 AND instruction1(31 DOWNTO 0) = "100011") else '0';

  branch_hazard <= '1' when instruction1_type = 2 or instruction1(31 DOWNTO 26) = "000100" or instruction1(31 DOWNTO 26) = "000101" or
                            instruction2_type = 2 or instruction2(31 DOWNTO 26) = "000100" or instruction2(31 DOWNTO 26) = "000101" or
                            instruction3_type = 2 or instruction3(31 DOWNTO 26) = "000100" or instruction3(31 DOWNTO 26) = "000101"or
                            instruction4_type = 2 or instruction4(31 DOWNTO 26) = "000100" or instruction4(31 DOWNTO 26) = "000101"
                            else '0';


  STALL_REQUEST <= op1_hazard or op2_hazard or branch_hazard;
  PROCESS(clock)
    BEGIN
    IF(clock'event AND clock = '1') THEN
      instruction4 <= instruction3;
      instruction3 <= instruction2;
      instruction2 <= instruction1;
      instruction1 <= ifid_IR;
    END IF;
  END PROCESS;


 
END hazard_detection_arch;
