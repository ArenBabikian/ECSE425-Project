LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ifid_buffer IS
PORT( clock : IN STD_LOGIC;
      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stall_request : IN STD_LOGIC;
      IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_en : OUT STD_LOGIC;
      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ifid_buffer;

ARCHITECTURE ifid_buffer_arch OF ifid_buffer IS
SIGNAL tmpIR : STD_LOGIC_VECTOR(0 TO 31);
BEGIN
tmpIR <= "00000000000000000000000000100000" WHEN (stall_request = '1') ELSE IR;
PROCESS(clock)
BEGIN
  IF (clock'EVENT AND clock = '1') THEN
    pc_out <= pc_in;
    IR_out <= tmpIR;
    IF (stall_request = '1') THEN
      pc_en <= '0';
    ELSE
      pc_en <= '1';
    END IF;
  END IF;
END PROCESS;
END ifid_buffer_arch;
