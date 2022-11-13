library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

library work;
use work.logger.all;
use work.operations.all;
use work.ss_math.all;


entity mux_tb is
end mux_tb;

architecture test of mux_tb is
	signal selector	: std_logic := '0';
	signal d_in0	: data_bus := (others => '0');
	signal d_in1	: data_bus := (others => '0');
	signal d_out	: data_bus := (others => '0');

	
	constant DEC_100	:	data_bus := int_to_vec(100, data_bus'length);
	constant DEC_200	:	data_bus := int_to_vec(200, data_bus'length);

begin
	dut : entity work.mux port map(
		selector => selector, d_in0 => d_in0,
		d_in1 => d_in1, d_out => d_out);
	
	stimulus : process
	begin
		wait for 1 ns;
		d_in0 <= DEC_100;
		d_in1 <= DEC_200;
		selector <= '0';
		wait for 1 ns;
		checkEqual(DEC_100, d_out, "Checking selector in 0");
		selector <= '1';
		wait for 1 ns;
		checkEqual(DEC_200, d_out, "Checking selector in 1");
		wait for 50 ns;
		stop;
	end process;
end architecture;
