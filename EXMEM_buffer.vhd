LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Forwarding remains to be implemented.

ENTITY EXMEM_buffer IS
PORT ( clock : IN STD_LOGIC;
       Branch_Taken_in : IN STD_LOGIC;
       ALU_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       THREE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       FIVE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       Branch_Taken_out : OUT STD_LOGIC;
       ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       THREE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       FIVE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END EXMEM_buffer;

ARCHITECTURE EXMEM_buffer_arch OF EXMEM_buffer IS
BEGIN
PROCESS(clock)
BEGIN
  IF(clock'EVENT AND clock = '1') THEN
    Branch_Taken_out <= Branch_Taken_in;
    THREE_out <= THREE_in;
    ALU_out <= ALU_in;
    FIVE_out <= FIVE_in;
  END IF;
END PROCESS;
END EXMEM_buffer_arch;
