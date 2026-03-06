library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_TB is
end RegisterFile_TB;

architecture TB of RegisterFile_TB is

signal clk : std_logic := '0';
signal RegWrite : std_logic := '0';

signal Read_reg1 : std_logic_vector(4 downto 0);
signal Read_reg2 : std_logic_vector(4 downto 0);
signal Write_reg : std_logic_vector(4 downto 0);

signal Write_data : std_logic_vector(31 downto 0);
signal Read_data1 : std_logic_vector(31 downto 0);
signal Read_data2 : std_logic_vector(31 downto 0);

constant clk_period : time := 20 ns;

begin

UUT: entity work.RegisterFile
port map(
    clk => clk,
    RegWrite => RegWrite,
    Read_reg1 => Read_reg1,
    Read_reg2 => Read_reg2,
    Write_reg => Write_reg,
    Write_data => Write_data,
    Read_data1 => Read_data1,
    Read_data2 => Read_data2
);

-- Clock
clk_process : process
begin
    while true loop
        clk <= '0';
        wait for clk_period/2;

        clk <= '1';
        wait for clk_period/2;
    end loop;
end process;


stimulus : process
begin

    ------------------------------------------------
    -- Test 1 : Write in R5
    ------------------------------------------------
    RegWrite <= '1';
    Read_reg1 <= "00000";
    Read_reg2 <= "00000";
    Write_reg <= "00101";
    Write_data <= x"AAAA_BBBB";

    wait until falling_edge(clk);

    ------------------------------------------------
    -- Test 2 : Read R5
    ------------------------------------------------
    Read_reg2 <= "00000";
    RegWrite <= '0';
    Read_reg1 <= "00101";

    wait for clk_period;

    ------------------------------------------------
    -- Test 3 : RegWrite = 0 (R10 should stay zero)
    ------------------------------------------------
    Write_reg <= "01010";
    Write_data <= x"1234_5678";

    wait until falling_edge(clk);

    Read_reg1 <= "01010";
    Read_reg2 <= "00000";

    wait for clk_period;

    ------------------------------------------------
    -- Test 4 : Read two registers
    ------------------------------------------------
    Read_reg1 <= "00101";
    Read_reg2 <= "01010";

    wait for clk_period;

    ------------------------------------------------
    -- Test 5 : Write and Read same register
    ------------------------------------------------
    RegWrite <= '1';
    Write_reg <= "00111";
    Write_data <= x"FFFF_FFFF";

    wait until falling_edge(clk);

    Read_reg1 <= "00111";

    wait for clk_period;

    wait;

end process;

end TB;