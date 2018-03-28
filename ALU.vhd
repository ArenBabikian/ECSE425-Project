LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU is
  PORT(
    Data1: in STD_LOGIC_VECTOR (31 downto 0);
    Data2: in STD_LOGIC_VECTOR (31 downto 0);
    ALUCtr : in  STD_LOGIC_VECTOR (3 downto 0);
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
      when "0000" => Result <= STD_LOGIC_VECTOR(signed(Data1) + signed(Data2));
      when "0001" => Result <= STD_LOGIC_VECTOR(signed(Data1) - signed(Data2));
      when "0010" => TEMP <= STD_LOGIC_VECTOR(signed(Data1) * signed(Data2));
                     HI <= TEMP(63 downto 32);
                     LO <= TEMP(31 downto 0);
      when "0011" => HI <= STD_LOGIC_VECTOR(signed(Data1) rem signed(Data2));
                     LO <= STD_LOGIC_VECTOR(signed(Data1) / signed(Data2));
      when "0100" => Result <= STD_LOGIC_VECTOR((signed(Data1) - signed(Data2)) srl 31);
      when "0101" => Result <= Data1 AND Data2;
      when "0110" => Result <= Data1 OR Data2;
      when "0111" => Result <= Data1 NOR Data2;
      when "1000" => Result <= Data1 XOR Data2;
      when "1001" => Result <= HI;
      when "1010" => Result <= LO;
      when "1011" => Result <= STD_LOGIC_VECTOR(to_bitvector(Data1) sll to_integer(signed(Data2)));
      when "1100" => Result <= STD_LOGIC_VECTOR(to_bitvector(Data1) srl to_integer(signed(Data2)));
      when "1101" => Result <= STD_LOGIC_VECTOR(to_bitvector(Data1) sra to_integer(signed(Data2)));
      when "1110" => Result <= Data2;
      when others => Result <= "000000000000000000000000000000000";
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
