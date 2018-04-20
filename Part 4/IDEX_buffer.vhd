LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Buffer between instruction decode stage and execute stage
ENTITY IDEX_buffer IS
PORT( clock : IN STD_LOGIC;
      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rs_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rt_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      extendData_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      IR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SEL1_in : IN STD_LOGIC;
      SEL2_in : IN STD_LOGIC;
      ALUCtr_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      WriteToReg_in : IN STD_LOGIC;
      WriteToMem_in : IN STD_LOGIC;
      BranchCtrl_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rs_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rt_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      extendData_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SEL1_out : OUT STD_LOGIC;
      SEL2_out : OUT STD_LOGIC;
      ALUCtr_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      WriteToReg_out : OUT STD_LOGIC;
      WriteToMem_out : OUT STD_LOGIC;
      BranchCtrl_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END IDEX_buffer;

ARCHITECTURE IDEX_buffer_arch OF IDEX_buffer is
BEGIN
PROCESS(clock)
  BEGIN
  -- Propagating signals through the pipeline
  IF(clock'EVENT AND clock = '1') THEN
    pc_out <= pc_in;
    rs_data_out <= rs_data_in;
    rt_data_out <= rt_data_in;
    extendData_out <= extendData_in;
    IR_out <= IR_in;
    SEL1_out <= SEL1_in;
    SEL2_out <= SEL2_in;
    ALUCtr_out <= ALUCtr_in;
    WriteToReg_out <= WriteToReg_in;
    WriteToMem_out <= WriteToMem_in;
    BranchCtrl_out <= BranchCtrl_in;
  END IF;
END PROCESS;
END IDEX_buffer_arch;
