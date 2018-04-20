-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 23.3.2018 20:49:20 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_Registers is
end tb_Registers;

architecture tb of tb_Registers is

    component Registers
        port (clock        : in std_logic;
              rs           : in std_logic_vector (4 downto 0);
              rt           : in std_logic_vector (4 downto 0);
              rd           : in std_logic_vector (4 downto 0);
              rd_data      : in std_logic_vector (31 downto 0);
              write_enable : in std_logic;
              reset        : in std_logic;
              rs_data      : out std_logic_vector (31 downto 0);
              rt_data      : out std_logic_vector (31 downto 0));
    end component;

    signal clock        : std_logic;
    signal rs           : std_logic_vector (4 downto 0);
    signal rt           : std_logic_vector (4 downto 0);
    signal rd           : std_logic_vector (4 downto 0);
    signal rd_data      : std_logic_vector (31 downto 0);
    signal write_enable : std_logic;
    signal reset        : std_logic;
    signal rs_data      : std_logic_vector (31 downto 0);
    signal rt_data      : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Registers
    port map (clock        => clock,
              rs           => rs,
              rt           => rt,
              rd           => rd,
              rd_data      => rd_data,
              write_enable => write_enable,
              reset        => reset,
              rs_data      => rs_data,
              rt_data      => rt_data);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clock is really your main clock signal
    clock <= TbClock;

    stimuli : process
    begin
        rs <= "00000";
        rt <= "00001";
        rd <= "00000";
        rd_data <= (others => '1');
        write_enable <= '0';
		reset <= '0';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        rs <= "00000";
        rt <= "00001";
        rd <= "00000";
        rd_data <= (others => '1');
        write_enable <= '1';

		wait for 100 * TbPeriod;

        rs <= "00000";
        rt <= "00001";
        rd <= "00001";
        rd_data <= (others => '1');
        write_enable <= '1';

		wait for 100 * TbPeriod;
        reset <= '1';
        rs <= "00000";
        rt <= "00001";
        rd <= "00001";
        rd_data <= (others => '1');
        write_enable <= '0';


        wait for 100 * TbPeriod;
        reset <= '0';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;


    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Registers of tb_Registers is
    for tb
    end for;
end cfg_tb_Registers;
