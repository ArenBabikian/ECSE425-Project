LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Buffer between instruction fetch stage and instruction decode stage
ENTITY ifid_buffer IS
PORT( clock : IN STD_LOGIC;
      pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stall_request : IN STD_LOGIC;
      IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      prediction_in : IN STD_LOGIC;
      prediction_out : OUT std_logic;
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      IR_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      flush : IN STD_LOGIC);

END ifid_buffer;

ARCHITECTURE ifid_buffer_arch OF ifid_buffer IS
SIGNAL tmpIR : STD_LOGIC_VECTOR(0 TO 31);
TYPE stallState IS (notStalled,stalled, stallBuffer);
SIGNAL state : stallState := notStalled;
BEGIN
-- if a stall is requested, instruction is add $r0, $r0, $r0
tmpIR <= "00000000000000000000000000100000" WHEN (stall_request = '1' OR flush = '1') ELSE IR;
PROCESS(clock,stall_request)
BEGIN
-- Propagating signals through the pipeline
  IF (clock'EVENT AND clock = '1') THEN
    pc_out <= pc_in;
    CASE state IS
      WHEN notStalled =>
        if(stall_request = '1') THEN
          state <= stalled;
        END IF;
      WHEN stalled =>
        if(stall_request = '0') THEN
          state <= stallBuffer;
        END IF;
      WHEN stallBuffer =>
        state <= notStalled;
      WHEN others =>
        state <= notStalled;
    END CASE;
  END IF;
  CASE state IS
      WHEN notStalled =>
        if(stall_request = '1') THEN
          state <= stalled;
        END IF;
      WHEN stalled =>
        if(stall_request = '0') THEN
          state <= stallBuffer;
        END IF;
      WHEN stallBuffer =>
      WHEN others =>
        state <= notStalled;
    END CASE;
END PROCESS;
IR_out <= IR WHEN state = notStalled AND flush = '0' else "00000000000000000000000000100000";
prediction_out <= prediction_in;
END ifid_buffer_arch;
