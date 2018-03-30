LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Controller IS

  PORT( IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AluCtr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Reg1Sel : OUT STD_LOGIC;
        Reg2Sel : OUT STD_LOGIC;
        SignExtSel : OUT STD_LOGIC;
        WriteToReg : OUT STD_LOGIC;
        WriteToMem : OUT STD_LOGIC;
        BranchCtrl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END Controller;

ARCHITECTURE Controller_arch of Controller IS
  SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL functionCode : STD_LOGIC_VECTOR(5 DOWNTO 0);
  BEGIN
    opcode <= IR(31 DOWNTO 26);
    functionCode <= IR(5 DOWNTO 0);
    PROCESS(IR)
      BEGIN
        CASE opcode is
          WHEN "000000" =>
            SignExtSel <= '0'; --Zero Extend the signal
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "11";--Make sure that branch is never taken
            if(functionCode = "100000") THEN --ADD
              AluCtr <= "00000";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "100010") THEN--SUB
              AluCtr <= "00001";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "011000") THEN--MUL
              AluCtr <= "00010";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '0'; --Function doesn't require writing to any register
            ELSIF(functionCode = "011010") THEN--DIV
              AluCtr <= "00011";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '0'; --Function doesn't require writing to any register
            ELSIF(functionCode = "101010") THEN--SLT
              AluCtr <= "00100";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "100100") THEN--AND
              AluCtr <= "00101";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "100101") THEN--OR
              AluCtr <= "00110";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "100111") THEN--NOR
              AluCtr <= "00111";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "100110") THEN--XOR
              AluCtr <= "01000";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "010000") THEN--MFHI
              AluCtr <= "01001";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "010010") THEN--MFLO
              AluCtr <= "01010";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "000000") THEN --SLL
              AluCtr <= "01011";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "000010") THEN--SRL
              AluCtr <= "01100";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "000011") THEN--SRA
              AluCtr <= "01101";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '1'; --Function requires writing to a register
            ELSIF(functionCode = "001000") THEN--JR
              AluCtr <= "00000";
              Reg1Sel <= '1'; --Select Rs Data
              Reg2Sel <= '0'; --Select Rt as Data
              WriteToReg <= '0'; --Function doesn't require writing to any register
              BranchCtrl <= "00";--Always takes the branch
            END IF;
          WHEN "001000" => --ADDI
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "00000";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "001010" => -- SLTI
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "00100";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "001100" => -- ANDI
            SignExtSel <= '0'; --Zero Extend the signal
            AluCtr <= "00101";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "001101" => --ORI
            SignExtSel <= '0'; --Zero Extend the signal
            AluCtr <= "00110";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "001110" => --XORI
            SignExtSel <= '0'; --Zero Extend the signal
            AluCtr <= "01000";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "001111" => --LUI
            SignExtSel <= '0'; --Zero Extend the signal
            AluCtr <= "01110";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "100011" => --LW
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "00000";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
          WHEN "101011" => --SW
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "00000";
            Reg1Sel <= '1'; --Select Rs Data
            Reg2Sel <= '1'; --Select Immediate as Data
            WriteToReg <= '0'; --Function doesn't require writing to any register
            WriteToMem <= '1'; --Function requires writing to memory
          WHEN "000100" => --BEQ
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "01111";
            Reg1Sel <= '0'; --Select PC as Data
            Reg2Sel <= '0'; --Select Rt as Data
            WriteToReg <= '0'; --Function doesn't require writing to any register
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "01";
          WHEN "000101" => --BNE
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "01111";
            Reg1Sel <= '0'; --Select PC as Data
            Reg2Sel <= '0'; --Select Rt as Data
            WriteToReg <= '0'; --Function doesn't require writing to any register
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "10";
          WHEN "000010" => --J
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "10000";
            Reg1Sel <= '0'; --Select PC as Data
            Reg2Sel <= '0'; --Select Rt as Data
            WriteToReg <= '0'; --Function doesn't require writing to any register
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "00";--Always takes the branch
          WHEN "000011" => --JAL
            SignExtSel <= '0'; --Sign Extend the signal
            AluCtr <= "10000";
            Reg1Sel <= '0'; --Select PC as Data
            Reg2Sel <= '0'; --Select Rt as Data
            WriteToReg <= '1'; --Function requires writing to a register
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "00";--Always takes the branch
          WHEN others =>
          	AluCtr <= "11111";
            WriteToReg <= '0'; --Function doesn't require writing to any register
            WriteToMem <= '0'; --Function doesn't require writing to memory
            BranchCtrl <= "11";--Make sure that branch is never taken
          END CASE;

    END PROCESS;

END Controller_arch;
