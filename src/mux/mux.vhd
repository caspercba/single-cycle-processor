library ieee;
use ieee.std_logic_1164.all;

entity mux is
	generic(datawidth	:	integer:=64);
	subtype  bus_data is std_logic_vector(datawidth-1 downto 0);
	port(
		selector	: in	std_logic := '0';
		d_in0, d_in1	: in	bus_data;
		d_out		: out	bus_data
	);
end mux;

architecture behavioural of mux is
begin
	with selector select
		d_out	<=	d_in0 when '0',
		       		d_in1 when '1';
end architecture;
