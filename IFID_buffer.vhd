LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ifid_buffer IS
PORT( clock : IN STD_LOGIC;
      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_en : OUT STD_LOGIC;
      stall_request : IN STD_LOGIC;
      IR : IN STD_LOGIC_VECTOR(0 TO 31);
      IR_out : OUT STD_LOGIC_VECTOR(0 TO 31);
      IFID_REGISTER1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      IFID_REGISTER2 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END ifid_buffer;

ARCHITECTURE ifid_buffer_arch OF ifid_buffer IS
SIGNAL tmpIR : STD_LOGIC_VECTOR(0 TO 31);
BEGIN
tmpIR <= "00000000000000000000000000100000" WHEN (stall_request = '1') ELSE IR;
buffer : PROCESS(clock)
BEGIN
  IF (clock'EVENT AND clock = '1')
    IFID_REGISTER1 <= tmpIR(6 TO 10);
    IFID_REGISTER2 <= tmpIR(11 TO 15);
    pc_out <= pc_in;
    pc_en <= '0' WHEN (stall_request = '1') ELSE '1';
    IR_out <= tmpIR;
  END IF;
END PROCESS buffer;
END ifid_buffer_arch;
