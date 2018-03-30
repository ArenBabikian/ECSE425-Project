LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU is
  PORT(
    Data1: in STD_LOGIC_VECTOR (31 downto 0);
    Data2: in STD_LOGIC_VECTOR (31 downto 0);
    ALUCtr : in  STD_LOGIC_VECTOR (4 downto 0);
    IR : in STD_LOGIC_VECTOR(31 downto 0);
    Zero : out STD_LOGIC;
    ALU_Result : out STD_LOGIC_VECTOR (31 downto 0)
  );
END ALU;

ARCHITECTURE Behavioral OF ALU is
  SIGNAL TEMP : STD_LOGIC_VECTOR(63 downto 0);
  SIGNAL HI : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL LO : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL Result : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL Z : STD_LOGIC;

BEGIN
  PROCESS(ALUCtr, Data1, Data2)
    BEGIN
    case ALUCtr is
      when "00000" => Result <= STD_LOGIC_VECTOR(signed(Data1) + signed(Data2)); --ADD & ADDI
      when "00001" => Result <= STD_LOGIC_VECTOR(signed(Data1) - signed(Data2)); --SUB
      when "00010" => TEMP <= STD_LOGIC_VECTOR(signed(Data1) * signed(Data2)); --MUL
                     HI <= TEMP(63 downto 32);
                     LO <= TEMP(31 downto 0);
      when "00011" => HI <= STD_LOGIC_VECTOR(signed(Data1) rem signed(Data2)); --DIV
                     LO <= STD_LOGIC_VECTOR(signed(Data1) / signed(Data2));
      when "00100" => Result <= STD_LOGIC_VECTOR((signed(Data1) - signed(Data2)) srl 31); --SLT & SLTI
      when "00101" => Result <= Data1 AND Data2; -- AND & ANDI
      when "00110" => Result <= Data1 OR Data2; -- OR & ORI
      when "00111" => Result <= Data1 NOR Data2; -- NOR
      when "01000" => Result <= Data1 XOR Data2; -- XOR & XORI
      when "01001" => Result <= HI; -- MFHI
      when "01010" => Result <= LO; -- MFLO
      when "01011" => Result <= to_STDLOGICVECTOR(to_bitvector(Data1) sll to_integer(signed(Data2))); -- SLL
      when "01100" => Result <= to_STDLOGICVECTOR(to_bitvector(Data1) srl to_integer(signed(Data2))); -- SRL
      when "01101" => Result <= to_STDLOGICVECTOR(to_bitvector(Data1) sra to_integer(signed(Data2))); -- SRA
      when "01110" => Result <= Data2(15 DOWNTO 0) & std_logic_vector(to_unsigned(0, 16)); --LUI
      when "01111" => Result <= STD_LOGIC_VECTOR(unsigned(Data1) + unsigned(Data2(15 DOWNTO 0)) * 4);   --BEQ & BNE
      when "10000" => Result <= Data1(31 DOWNTO 28) & IR(25 DOWNTO 0) & "00"; -- J & JAL
      when others => Result <= "00000000000000000000000000000000";
                     Z <= '0';
    END case;

    if(to_integer(signed(Result)) /= 0) then
      Z <= '1';
    else
      Z <= '0';
    END if;
  END PROCESS;

  ALU_Result <= Result;
  Zero <= Z;
END ARCHITECTURE;
