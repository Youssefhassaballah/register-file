library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        clk          : in  std_logic;
        RegWrite     : in  std_logic;
        Read_reg1    : in  std_logic_vector(4 downto 0);
        Read_reg2    : in  std_logic_vector(4 downto 0);
        Write_reg    : in  std_logic_vector(4 downto 0);
        Write_data   : in  std_logic_vector(31 downto 0);
        Read_data1   : out std_logic_vector(31 downto 0);
        Read_data2   : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type register_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs : register_array := (others => (others => '0'));
begin

    process(clk)
    begin
        if falling_edge(clk) then
            if RegWrite = '1' then
                regs(to_integer(unsigned(Write_reg))) <= Write_data;
            end if;
        end if;
    end process;

    Read_data1 <= regs(to_integer(unsigned(Read_reg1)));
    Read_data2 <= regs(to_integer(unsigned(Read_reg2)));

end Behavioral;
