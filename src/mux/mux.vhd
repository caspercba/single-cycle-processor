library ieee;
use ieee.std_logic_1164.all;
library work;
use work.operations.all;

entity mux is
	port(
		selector	: in	std_logic := '0';
		d_in0, d_in1	: in	data_bus;
		d_out		: out 	data_bus	
	);
	
end mux;

architecture behavioural of mux is
begin
	with selector select
		d_out	<=	d_in0 when '0',
		       		d_in1 when '1',
				(others=>'0') when others;
end architecture;
