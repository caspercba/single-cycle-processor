library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use std.textio.all;
use std.env.stop;

entity flopr_tb is
end flopr_tb;

architecture test of flopr_tb is
	constant half_period	: time :=5 ns;
	constant datawidth	: integer := 64;
	component flopr
	port(
		clk: in std_logic;
		reset: in std_logic;
		d: in std_logic_vector(datawidth - 1 downto 0);
		q: out std_logic_vector(datawidth -1 downto 0)
	);
	end component;

	signal clk : std_logic := '0';
	signal reset: std_logic := '1';
	signal d: std_logic_vector(datawidth - 1 downto 0);
	signal q: std_logic_vector(datawidth -1 downto 0);
	type test_numbers_array is array (natural range <>) of std_logic_vector(datawidth - 1 downto 0);

	constant test_numbers : test_numbers_array :=(
	x"0000000000000001",
	x"0000000000000010",
	x"0000000000000011",
	x"0000000000000100",
	x"0000000000000101",
	x"1000000000000000",
	x"1100000000000001",
	x"1110000000000001",
	x"1111000000000001",
	x"1111100000000001");

begin
	flopr_64 : entity work.flopr
	generic map(datawidth=>64)	
	port map(clk=>clk,reset=>reset, d=>d, q=>q);
		 
		clk_process: process(clk)
		begin
			clk <= not clk after half_period;
		end process clk_process;

	stimulus: process
		variable index: integer :=0;
	begin
		reset <= '1';
		for i in 0 to 4 loop
			wait until falling_edge(clk);
			d<=test_numbers(i);
			wait until rising_edge(clk);
			assert q =x"0000000000000000";
		end loop;
		reset <= '0';
		for i in 5 to 9 loop
			wait until falling_edge(clk);
			d<=test_numbers(i);
			wait for 1 ns;
			report "Testing... DATA: " & to_hex_string(d);
			wait until rising_edge(clk);
			wait for 1 ns;
			report "Testing... Result: " & to_hex_string(q);
			assert q=test_numbers(i) ;
			wait until rising_edge(clk);
		end loop;
		report "ENd";
		stop;
 				
	end process stimulus;
end test;
