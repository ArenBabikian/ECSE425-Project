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
        forward_A : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        forward_B : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        forward_C : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        exmem_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        memwb_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUCtr1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        BranchCtrl1: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Branch_Taken :  OUT STD_LOGIC;
        rt_data_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IRTypeEX_in : in INTEGER;
        IRTypeEX_out : out INTEGER;
        rt_exmem_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rt_memwb_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
END EX;

ARCHITECTURE EX_arch OF EX IS

COMPONENT mux is
  PORT( SEL : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT mux4to1 IS
  PORT( SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        C   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        D   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
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
SIGNAL X2,X3,X4 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rsBranch, rtBranch : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ZEROALU : STD_LOGIC;
SIGNAL rt_forwardedData : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
-- Port map of components
mux1: mux port map(SEL1,pc_in,X1,X3);
mux2: mux port map(SEL2,extendData,X2,X4);
mux3: mux4to1 port map(forward_A,rs_data,memwb_data,exmem_data,rs_data,X1);
mux4: mux4to1 port map(forward_B,rt_data,memwb_data,exmem_data,rt_data,X2);
mux5: mux4to1 port map(forward_C,rt_data,rt_memwb_data,rt_exmem_data,rt_data, rt_forwardedData);
mux6: mux4to1 port map(forward_A,rs_data,memwb_data,exmem_data,rs_data,rsBranch);
mux7: mux4to1 port map(forward_B,rt_data,memwb_data,exmem_data,rt_data,rtBranch);

ALU1: ALU port map(X3,X4,ALUCtr1,IR,ZEROALU,ALU_OUT);
BranchZero1: BranchZero port map(rsBranch,rtBranch,BranchCtrl1,Branch_Taken);
-- forwarding signals
rt_data_OUT <= rt_forwardedData;
IR_OUT <= IR;
IRTypeEX_out <= IRTypeEX_in;

END EX_arch;
