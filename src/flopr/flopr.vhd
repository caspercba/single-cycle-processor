library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flopr is
	generic( datawidth: integer := 64);
	port(
		clk, reset	: in std_logic;
		d, q		: in std_logic_vector(datawidth - 1 downto 0)
	);
end flopr;

architecture behavioural of flopr is
--signal clk	: std_logic;
begin
	process(clk)
	begin
		if(reset='1') then
			q <= (others => '0');
		elsif(rising_edge(clk)) then
			q <= d;
		end if;
	end process;
end behavioural;
