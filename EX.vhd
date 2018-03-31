LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Execute Stage
ENTITY EX IS
  PORT( pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rs_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rt_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        extendData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SEL1 : IN STD_LOGIC;
        SEL2 : IN STD_LOGIC;
        ALUCtr1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        BranchCtrl1: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Branch_Taken :  OUT STD_LOGIC;
        rt_data_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END EX;

ARCHITECTURE EX_arch OF EX IS

COMPONENT mux is
  PORT( SEL : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT ALU is
  PORT(
  Data1: in STD_LOGIC_VECTOR (31 downto 0);
  Data2: in STD_LOGIC_VECTOR (31 downto 0);
  ALUCtr : in  STD_LOGIC_VECTOR (4 downto 0);
  IR : in STD_LOGIC_VECTOR(31 downto 0);
  Zero : out STD_LOGIC;
  ALU_Result : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;

COMPONENT BranchZero is
  PORT(
    rs: in STD_LOGIC_VECTOR (31 downto 0);
    rt: in STD_LOGIC_VECTOR (31 downto 0);
    branchCtrl : in STD_LOGIC_VECTOR(1 downto 0);
    BranchTaken : out STD_LOGIC);
END COMPONENT;

SIGNAL X1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL X2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ZEROALU : STD_LOGIC;

BEGIN
-- Port map of components
mux1: mux port map(SEL1,pc_in,rs_data,X1);
mux2: mux port map(SEL2,rt_data,extendData,X2);
ALU1: ALU port map(X1,X2,ALUCtr1,IR,ZEROALU,ALU_OUT);
BranchZero1: BranchZero port map(rs_data,rt_data,BranchCtrl1,Branch_Taken);
-- forwarding signals
rt_data_OUT <= rt_data;
IR_OUT <= IR;


END EX_arch;
