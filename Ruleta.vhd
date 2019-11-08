library ieee;
use ieee.std_logic_1164.all;
entity Ruleta is
  port (clk : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        seed : in std_logic_vector(7 downto 0);
        random : out std_logic_vector(7 downto 0);
		  rul : out std_logic_vector(17 downto 0));
end Ruleta;
architecture funcional of Ruleta is
  signal lfsr_reg : std_logic_vector(7 downto 0);
begin
  process(clk, reset)
  begin
    if(reset='1') then
      lfsr_reg <= (others=>'0');
    elsif(clk'event and clk='1') then
      if(load='1') then
        lfsr_reg <= seed;
      else
        lfsr_reg(0) <= lfsr_reg(7);
        lfsr_reg(1) <= lfsr_reg(0);
        lfsr_reg(2) <= lfsr_reg(1) xnor lfsr_reg(7);
        lfsr_reg(3) <= lfsr_reg(2) xnor lfsr_reg(7);
        lfsr_reg(4) <= lfsr_reg(3) xnor lfsr_reg(7);
        lfsr_reg(5) <= lfsr_reg(4);
        lfsr_reg(6) <= lfsr_reg(5);
        lfsr_reg(7) <= lfsr_reg(6);
      end if;
    end if;
  end process;
  random <= lfsr_reg;
  rul <= "0000000000" & lfsr_reg;
end architecture;