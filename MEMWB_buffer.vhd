LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Buffer between memory stage and write back stage
ENTITY MEMWB_buffer IS
PORT( clock : IN STD_LOGIC;
			memdata_in : IN std_logic_vector (31 downto 0);
			aludata_in : IN std_logic_vector (31 downto 0);
			IR_in : IN std_logic_vector (31 downto 0);
			WriteToReg_in : IN std_logic;
			memdata_out : out std_logic_vector (31 downto 0);
			aludata_out : out std_logic_vector (31 downto 0);
			IR_out : out std_logic_vector (31 downto 0);
			WriteToReg_out : OUT std_logic);
END MEMWB_buffer;

ARCHITECTURE MEMWB_buffer_arch OF MEMWB_buffer is
BEGIN
PROCESS(clock)
	BEGIN
		IF (clock'EVENT AND clock = '1') THEN
			memdata_out <= memdata_in;
			aludata_out <= aludata_in;
			IR_out <= IR_in;
			WriteToReg_out <= WriteToReg_in;
		END IF;
	END PROCESS;
END MEMWB_buffer_arch;
