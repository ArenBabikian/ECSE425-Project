LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY IDEX_buffer IS
-- Placeholder name for now
PORT( clock : IN STD_LOGIC;
      ONE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      TWO_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      THREE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      FOUR_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      FIVE_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SEL1_in : IN STD_LOGIC;
      SEL2_in : IN STD_LOGIC;
      ALUCtr_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      ONE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      TWO_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      THREE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      FOUR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      FIVE_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SEL1_out : OUT STD_LOGIC;
      SEL2_out : OUT STD_LOGIC;
      ALUCtr_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END IDEX_buffer;

ARCHITECTURE IDEX_buffer_arch OF IDEX_buffer is
  buffer: PROCESS(clock)
  BEGIN
    ONE_out <= ONE_in;
    TWO_out <= TWO_in;
    THREE_out <= THREE_in;
    FOUR_out <= FOUR_in;
    FIVE_out <= FIVE_in;
    SEL1_out <= SEL1_in;
    SEL2_out <= SEL2_in;
    ALUCtr_out <= ALUCtr_in;
  END PROCESS buffer;
END IDEX_buffer_arch;
