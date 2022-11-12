library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.operations.all;

entity flopr is
	port(
		clk, reset	: in std_logic;
		d		: in data_bus; 
		q		: out data_bus 
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
