LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY WB IS
	PORT( 	
		mem_in : IN std_logic_vector (31 downto 0);
		alu_in  : IN std_logic_vector (31 downto 0);
		ir_in : IN std_logic_vector (31 downto 0);
		mux_out : out std_logic_vector (31 downto 0);
		ir_out : out std_logic_vector (31 downto 0)
		);
END WB;

ARCHITECTURE WB_arch OF WB IS

COMPONENT mux is
  PORT( SEL : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        x   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

signal ind : std_logic;

BEGIN

--this checks whether the ir contains information for a load or store command.
--in that case, ind becomes 1 and allows the mux to choose the memory input 
--over the alu input
ind <= '1' when (ir_in(31 downto 26) = "101011" or ir_in(31 downto 26) = "100011") 
else '0';

mux1: mux port map(ind,mem_in,alu_in,mux_out);

ir_out <= ir_in;

END WB_arch;
