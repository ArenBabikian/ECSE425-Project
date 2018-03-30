LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY WB IS
	PORT(
        mux_sel : IN std_logic;
		mem_in : IN std_logic_vector (31 downto 0);
		alu_in  : IN std_logic_vector (31 downto 0);
		temp_in : IN std_logic_vector (31 downto 0);

		mux_out : out std_logic_vector (31 downto 0);
		temp_out : out std_logic_vector (31 downto 0)
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

BEGIN
mux1: mux port map(mux_sel,mem_in,alu_in,mux_out);

temp_out <= temp_in;

END WB_arch;
