LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Buffer between instruction fetch stage and instruction decode stage
ENTITY ifid_buffer IS
PORT( clock : IN STD_LOGIC;
      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stall_request : IN STD_LOGIC;
      IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ifid_buffer;

ARCHITECTURE ifid_buffer_arch OF ifid_buffer IS
SIGNAL tmpIR : STD_LOGIC_VECTOR(0 TO 31);
BEGIN
-- if a stall is requested, instruction is add $r0, $r0, $r0
tmpIR <= "00000000000000000000000000100000" WHEN (stall_request = '1') ELSE IR;
PROCESS(clock)
BEGIN
-- Propagating signals through the pipeline
  IF (clock'EVENT AND clock = '1') THEN
    pc_out <= pc_in;
    IR_out <= tmpIR;
  END IF;
END PROCESS;
END ifid_buffer_arch;
