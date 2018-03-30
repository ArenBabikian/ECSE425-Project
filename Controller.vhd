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
            SignExtSel <= '0';
            WriteToMem <= '0';
            BranchCtrl <= "11";
            if(functionCode = "100000") THEN --ADD
              AluCtr <= "00000";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "100010") THEN--SUB
              AluCtr <= "00001";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "011000") THEN--MUL
              AluCtr <= "00010";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '0';
            ELSIF(functionCode = "011010") THEN--DIV
              AluCtr <= "00011";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '0';
            ELSIF(functionCode = "101010") THEN--SLT
              AluCtr <= "00100";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "100100") THEN--AND
              AluCtr <= "00101";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "100101") THEN--OR
              AluCtr <= "00110";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "100111") THEN--NOR
              AluCtr <= "00111";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "100110") THEN--XOR
              AluCtr <= "01000";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "010000") THEN--MFHI
              AluCtr <= "01001";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "010010") THEN--MFLO
              AluCtr <= "01010";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "000000") THEN --SLL
              AluCtr <= "01011";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "000010") THEN--SRL
              AluCtr <= "01100";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "000011") THEN--SRA
              AluCtr <= "01101";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '1';
            ELSIF(functionCode = "001000") THEN--JR
              AluCtr <= "00000";
              Reg1Sel <= '1';
              Reg2Sel <= '0';
              WriteToReg <= '0';
              BranchCtrl <= "00";
            END IF;
          WHEN "001000" => --ADDI
            SignExtSel <= '1';
            AluCtr <= "00000";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "001010" => -- SLTI
            SignExtSel <= '1';
            AluCtr <= "00100";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "001100" => -- ANDI
            SignExtSel <= '0';
            AluCtr <= "00101";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "001101" => --ORI
            SignExtSel <= '0';
            AluCtr <= "00110";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "001110" => --XORI
            SignExtSel <= '0';
            AluCtr <= "01000";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "001111" => --LUI
            SignExtSel <= '0';
            AluCtr <= "01110";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "100011" => --LW
            SignExtSel <= '1';
            AluCtr <= "00000";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '1';
            WriteToMem <= '0';
          WHEN "101011" => --SW
            SignExtSel <= '1';
            AluCtr <= "00000";
            Reg1Sel <= '1';
            Reg2Sel <= '1';
            WriteToReg <= '0';
            WriteToMem <= '1';
          WHEN "000100" => --BEQ
            SignExtSel <= '1';
            AluCtr <= "01111";
            Reg1Sel <= '0';
            Reg2Sel <= '0';
            WriteToReg <= '0';
            WriteToMem <= '0';
            BranchCtrl <= "01";
          WHEN "000101" => --BNE
            SignExtSel <= '1';
            AluCtr <= "01111";
            Reg1Sel <= '0';
            Reg2Sel <= '0';
            WriteToReg <= '0';
            WriteToMem <= '0';
            BranchCtrl <= "10";
          WHEN "000010" => --J
            SignExtSel <= '1';
            AluCtr <= "10000";
            Reg1Sel <= '0';
            Reg2Sel <= '0';
            WriteToReg <= '0';
            WriteToMem <= '0';
            BranchCtrl <= "00";
          WHEN "000011" => --JAL
            SignExtSel <= '1';
            AluCtr <= "10000";
            Reg1Sel <= '0';
            Reg2Sel <= '0';
            WriteToReg <= '1';
            WriteToMem <= '0';
            BranchCtrl <= "00";
          WHEN others =>
          	AluCtr <= "11111";
            WriteToReg <= '0';
            WriteToMem <= '0';
            BranchCtrl <= "11";
          END CASE;

    END PROCESS;

END Controller_arch;
