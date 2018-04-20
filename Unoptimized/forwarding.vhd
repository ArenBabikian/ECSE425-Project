LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- forwarding module
ENTITY forwarding IS
PORT( exmem_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      memwb_ir : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ir: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      idex_type : IN INTEGER;
      forward_A : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forward_B : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forward_C : out STD_LOGIC_VECTOR(1 DOWNTO 0);
      IRTypeEXMEM_in : in INTEGER;
      IRTypeMEMWB_in : in INTEGER);
END forwarding;

ARCHITECTURE forwarding_arch OF forwarding IS

SIGNAL exmem_rd , memwb_rd: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL R_memwb , R_exmem : STD_LOGIC;
SIGNAL rs, rt : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN
-- Gets RD FROM EX/MEM buffer and MEM/WB buffer
exmem_rd <= exmem_ir(15 DOWNTO 11) when (IRTypeEXMEM_in = 0) else exmem_ir(20 DOWNTO 16);
memwb_rd <= memwb_ir(15 DOWNTO 11) when (IRTypeMEMWB_in = 0) else memwb_ir(20 DOWNTO 16);
-- checks if R operation is EX/MEM buffer or MEM/WB buffer
R_exmem <= '1' WHEN(IRTypeEXMEM_in = 0 OR IRTypeEXMEM_in = 1) ELSE '0';
R_memwb <= '1' WHEN(IRTypeMEMWB_in = 0 OR IRTypeMEMWB_in = 1) ELSE '0';
rs <= ir(25 DOWNTO 21);
rt <= ir(20 DOWNTO 16) when idex_type = 0 OR ir(31 downto 26) = "101011" OR ir(31 downto 26) = "000100" OR ir(31 downto 26) = "000101" else "00000";
-- Control Signal for 4 to 1 multiplexer for input A of ALU (top one)
forward_A <= "10" WHEN(exmem_rd /= "00000" and exmem_rd = rs and (idex_type = 0 or idex_type = 1) AND (exmem_ir(31 DOWNTO 26) /= "100011") and R_exmem = '1') ELSE
             "01" WHEN(memwb_rd /= "00000" and memwb_rd = rs and (idex_type = 0 or idex_type = 1) and R_memwb = '1') ELSE
             "00";

-- Control Signal for 4 to 1 multiplexer for input B of ALU (bottom one)
forward_B <= "10" WHEN(exmem_rd /= "00000" and exmem_rd = rt and (idex_type = 0 or idex_type = 1) AND (exmem_ir(31 DOWNTO 26) /= "100011") AND (ir(31 DOWNTO 26) /= "101011") and R_exmem = '1') ELSE
             "01" WHEN(memwb_rd /= "00000" and memwb_rd = rt and (idex_type = 0 or idex_type = 1) AND (ir(31 DOWNTO 26) /= "101011") and R_memwb = '1') ELSE
             "00";
forward_C <= "10" WHEN(exmem_rd /= "00000" and exmem_rd = rt and (idex_type = 0 or idex_type = 1) AND (exmem_ir(31 DOWNTO 26) /= "100011") AND  (ir(31 DOWNTO 26) = "101011") and R_exmem = '1') ELSE
             "01" WHEN(memwb_rd /= "00000" and memwb_rd = rt and (idex_type = 0 or idex_type = 1) AND (ir(31 DOWNTO 26) = "101011") and R_memwb = '1') ELSE
             "00";
END forwarding_arch;
