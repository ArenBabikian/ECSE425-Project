LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MEMWB_buffer IS
-- Placeholder name for now
PORT(
		clock : IN STD_LOGIC;
		memdata_in : IN std_logic_vector (31 downto 0);
		aludata_in : IN std_logic_vector (31 downto 0);
		temp_in : IN std_logic_vector (31 downto 0);
		WriteToReg_in : IN std_logic;

		memdata_out : out std_logic_vector (31 downto 0);
		aludata_out : out std_logic_vector (31 downto 0);
		temp_out : out std_logic_vector (31 downto 0);
		WriteToReg_out : OUT std_logic
		);

END MEMWB_buffer;

ARCHITECTURE MEMWB_buffer_arch OF MEMWB_buffer is
BEGIN
PROCESS(clock)
	BEGIN
		IF (clock'EVENT AND clock = '1') THEN
			memdata_out <= memdata_in;
			aludata_out <= aludata_in;
			temp_out <= temp_in;
			WriteToReg_out <= WriteToReg_in;
		END IF;
	END PROCESS;
END MEMWB_buffer_arch;
