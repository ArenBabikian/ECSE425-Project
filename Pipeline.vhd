library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (
	clk : in std_logic;
  );
end pipeline;

architecture behavioral of pipeline is

	--BUFFER COMPONENTS
	Component IFID_buffer is
		PORT( 
			clock : IN STD_LOGIC;
			pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_en : OUT STD_LOGIC;
			stall_request : IN STD_LOGIC;
			IR : IN STD_LOGIC_VECTOR(0 TO 31);
			IR_out : OUT STD_LOGIC_VECTOR(0 TO 31);
			IFID_REGISTER1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			IFID_REGISTER2 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
	END component;

	Component IDEX_buffer is
		PORT( 

		);
	END component;

	Component EXMEM_buffer is
		PORT( 

		);
	END component;

	Component MEMWB_buffer is
		PORT( 

		);
	END component;
	
	--STAGE COMPONENTS
	Component IFStage is
		PORT( 

		);
	END component;

	Component ID is
		PORT( 

		);
	END component;

	Component EX is
		PORT( 
			ONE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			TWO : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			FOUR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			SEL1 : IN STD_LOGIC;
			SEL2 : IN STD_LOGIC;
			ALUCtr1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Branch_Taken :  OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			THREE_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			FIVE_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	End Component;

	Component MEM is
		PORT( 
			clock : IN STD_LOGIC;
			AluData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			WriteDataMem : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Temp : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_en : IN STD_LOGIC;
			MemoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AluDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Temp_Out : OUT STD_LOGIC;
			SEL2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
		);
	END component;

	Component WB is
		PORT( 

		);
	END component;


-- test signals
	SIGNAL reset : std_logic := '0';
	SIGNAL clk : std_logic := '0';
	CONSTANT clk_period : TIME := 2 ns;

	SIGNAL s_addr : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_read : std_logic;
	SIGNAL s_readdata : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_write : std_logic;
	SIGNAL s_writedata : std_logic_vector (31 DOWNTO 0);
	SIGNAL s_waitrequest : std_logic;

	SIGNAL m_addr : INTEGER RANGE 0 TO 2147483647;
	SIGNAL m_read : std_logic;
	SIGNAL m_readdata : std_logic_vector (7 DOWNTO 0);
	SIGNAL m_write : std_logic;
	SIGNAL m_writedata : std_logic_vector (7 DOWNTO 0);
	SIGNAL m_waitrequest : std_logic;

--File R/W
FILE file_input : text;
FILE file_output : text;
CONSTANT command_size : natural := 32;
SIGNAL input_command : std_logic_vector (command_size-1 downto 0);
SIGNAL output_command : std_logic_vector(command_size-1 downto 0);




signal index : std_logic_vector(5 downto 0) := "00001";
signal tempOP1, tempOP2, tempOP3, tempOP4, tempOP5, 
	tempA1, tempC1, tempD1, tempE1,
	tempA2, tempC2, tempD2, tempE2,
	tempA3, tempE3, tempOP21,
	tempOP22, tempOP31,
	tempOP23 : integer := 0;

begin

process (clk)
begin


if (clk'event and clk = '1') then



--STAGE 5
if (index(4) = '1') then
-------------

	
op5 <= tempOP31 * tempOP4;

	tempOP5 <= tempOP31 * tempOP4;
	tempOP23 <= tempOP22;





---------------	
	index(5) <= '1';
	index(4) <= '0';
end if;


--STAGE 4
if (index(3) = '1') then
---------------




op4 <= tempA3 - tempE3;

	tempOP4 <= tempA3 - tempE3;
	tempOP31 <= tempOP3;
	tempOP22 <= tempOP21;	





---------------
	index(4) <= '1';
	index(3) <= '0';
end if;


--STAGE 3
if (index(2) = '1') then
---------------



	op3 <= tempC2 * tempD2;

	tempOP3 <= tempC2 * tempD2;
	tempOP21 <= tempOP2;
	tempA3 <= tempA2;
	tempE3 <= tempE2;



---------------
	index(3) <= '1';
	index(2) <= '0';
end if;

--STAGE 2
if (index(1) = '1') then
---------------






	op2 <= tempOP1 * 42;

	tempOP2 <= tempOP1 * 42;
	tempA2 <= tempA1;
	tempC2 <= tempC1;
	tempD2 <= tempD1;
	tempE2 <= tempE1;



---------------
	index(2) <= '1';
	index(1) <= '0';
end if;

--STAGE 1
if (index(0) = '1') then
---------------

	op1 <= a + b;

	tempOP1 <= a + b;
	tempA1 <= a;
	tempC1 <= c;
	tempD1 <= d;
	tempE1 <= e;




---------------
	index(1) <= '1';
end if;

			

end if;

end process;

end behavioral;