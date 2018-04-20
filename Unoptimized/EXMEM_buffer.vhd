LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Buffer between execute stage and memory stage
ENTITY EXMEM_buffer IS
PORT ( clock : IN STD_LOGIC;
       Branch_Taken_in : IN STD_LOGIC;
       ALU_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       rt_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
       WriteToRegInEXMEM : IN STD_LOGIC;
       WriteToMemInEXMEM : IN STD_LOGIC;
       WriteToRegOutEXMEM : OUT STD_LOGIC;
       WriteToMemOutEXMEM : OUT STD_LOGIC;
       Branch_Taken_out : OUT STD_LOGIC;
       ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       rt_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
       IRTypeEXMEM_in : in INTEGER;
       IRTypeEXMEM_out : out INTEGER);
END EXMEM_buffer;

ARCHITECTURE EXMEM_buffer_arch OF EXMEM_buffer IS
BEGIN
PROCESS(clock)
BEGIN
  -- Propagating signals through the pipeline
  IF(clock'EVENT AND clock = '1') THEN
    Branch_Taken_out <= Branch_Taken_in;
    rt_data_out <= rt_data_in;
    ALU_out <= ALU_in;
    IR_out <= IR_in;
    WriteToMemOutEXMEM <= WriteToMemInEXMEM;
    WriteToRegOutEXMEM <= WriteToRegInEXMEM;
    IRTypeEXMEM_out <= IRTypeEXMEM_in;
  END IF;
END PROCESS;
END EXMEM_buffer_arch;
