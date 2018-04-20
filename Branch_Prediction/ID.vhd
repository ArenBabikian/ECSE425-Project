LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Instruction Decode stage
ENTITY ID IS
PORT(
	clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    wb_mux : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    memwb_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg_en : IN STD_LOGIC;
    IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    rs_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    rt_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    extendData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    SEL1 : OUT STD_LOGIC;
    SEL2 : OUT STD_LOGIC;
    ALUCtr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    WriteToReg : OUT STD_LOGIC;
    WriteToMem : OUT STD_LOGIC;
	readRegister : in std_logic;
	register_address : in std_logic_vector(4 DOWNTO 0);
	IRTypeID_in : in INTEGER;
	IRTypeID_out : out INTEGER;
	btaken : out STD_LOGIC;
	bdestination : out STD_LOGIC_VECTOR(31 DOWNTO 0)
);


END ID;

ARCHITECTURE ID_arch OF ID IS

SIGNAL rs , rt , rd : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL s_rs_data, s_rt_data, s_extendData : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL BranchCtrl : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL data : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL extCtrl : STD_LOGIC;

COMPONENT REGISTERS IS
  PORT( clock : in STD_LOGIC;
  rs : in STD_LOGIC_VECTOR (4 DOWNTO 0);
  rt : in STD_LOGIC_VECTOR (4 DOWNTO 0);
  rd : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
  rd_data : in STD_LOGIC_VECTOR (31 DOWNTO 0);
  write_enable : in STD_LOGIC;
  reset : in STD_LOGIC;
  rs_data : out STD_LOGIC_VECTOR (31 DOWNTO 0);
  rt_data : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;

COMPONENT ExtImm IS
  PORT( data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        SignExtImm   : IN STD_LOGIC;
        extendData   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT Controller IS
PORT( IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      AluCtr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      Reg1Sel : OUT STD_LOGIC;
      Reg2Sel : OUT STD_LOGIC;
      SignExtSel : OUT STD_LOGIC;
      WriteToReg : OUT STD_LOGIC;
      WriteToMem : OUT STD_LOGIC;
      BranchCtrl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			IRType_out : out INTEGER);

END COMPONENT;

COMPONENT BranchZero is
  PORT(
    rs_data: in STD_LOGIC_VECTOR (31 downto 0);
    rt_data: in STD_LOGIC_VECTOR (31 downto 0);
    branchCtrl : in STD_LOGIC_VECTOR(1 downto 0);
    BranchTaken : out STD_LOGIC
  );
END COMPONENT;

component branch_destination is
PORT( branchCtrl : IN std_logic_vector(1 DOWNTO 0);
      extendData : IN std_logic_vector(31 DOWNTO 0);
      pc_in : IN std_logic_vector(31 DOWNTO 0);
      IR : IN std_logic_vector(31 DOWNTO 0);
      b_dest : OUT std_logic_vector(31 DOWNTO 0));
end component;

BEGIN
-- Splitting IR rs, rt and data
data <= IR(15 DOWNTO 0);
rt <= IR(20 DOWNTO 16);
-- Port map of the components
registers1 : REGISTERS port map(clock,rs,rt,rd,wb_mux,reg_en,reset,s_rs_data,s_rt_data);
controller1 : CONTROLLER port map(IR,ALUCtr,SEL1,SEL2,extCtrl,WriteToReg,WriteToMem,BranchCtrl,IRTypeID_out);
extimm1 : ExtImm port map(data,extCtrl,s_extendData);
branchzero1 : BranchZero port map(s_rs_data,s_rt_data,BranchCtrl,btaken);
bdest1 : branch_destination port map(BranchCtrl,s_extendData,pc_in,IR,bdestination);

-- Propagating signals through the pipeline
IR_out <= IR;
pc_out <= pc_in;
rs_data <= s_rs_data;
rt_data <= s_rt_data;
extendData <= s_extendData;

PROCESS(IR,readRegister,register_address,memwb_ir)
BEGIN
  IF(readRegister = '1') THEN
    rs <= register_address;
  ELSE
    rs <= IR(25 DOWNTO 21);
  END IF;
	IF(IRTypeID_in = 0)THEN
		rd <= memwb_ir(15 DOWNTO 11);
	ELSIF(IRTypeID_in = 1)THEN
		rd <= memwb_ir(20 DOWNTO 16);
	ELSE
		rd <= "00000";
	END IF;

END PROCESS;

END ID_arch;
