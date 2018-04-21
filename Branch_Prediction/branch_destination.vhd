LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY branch_destination IS
PORT( clock : IN std_logic;
      branchCtrl : IN std_logic_vector(1 DOWNTO 0);
      extendData : IN std_logic_vector(31 DOWNTO 0);
      pc_in : IN std_logic_vector(31 DOWNTO 0);
      IR : IN std_logic_vector(31 DOWNTO 0);
      b_dest : OUT std_logic_vector(31 DOWNTO 0));
END branch_destination;

ARCHITECTURE branch_destination_arch OF branch_destination IS
BEGIN
PROCESS(clock)
begin
  IF(rising_edge(clock)) then
    if(branchCtrl = "00") then
      b_dest <= pc_in(31 DOWNTO 28) & IR(25 DOWNTO 0) & "00";
    ELSIF(branchCtrl = "01" or branchCtrl = "10") then
      b_dest <= STD_LOGIC_VECTOR(unsigned(pc_in) + unsigned(extendData(15 DOWNTO 0)) * 4);
  ELSE
  b_dest <= "00000000000000000000000000000000";
end if;
end if;
end process;
END branch_destination_arch;
