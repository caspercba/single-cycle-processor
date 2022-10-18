
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use std.textio.all;
use std.env.stop;
use work.alu_helper.all;

entity alu_tb is
end alu_tb;

architecture test of alu_tb is
	
	constant num1: std_logic_vector := 50;	
	constant num2: std_logic_vector := -50;	
	constant num3: std_logic_vector := 1000000000;	
	constant num4: std_logic_vector := -1000000000;	

	component alu is
		port(
		a,b		: in std_logic_vector(63 downto 0);
		ALUControl	: in std_logic_vector(3 downto 0);
		result		: out std_logic_vector(63 downto 0);
		zero		: out std_logic
	);
	end component alu;
	
	signal a,b,result: std_logic_vector(63 downto 0);
	signal ALUControl: std_logic_vector(3 downto 0);
	signal zero	 : std_logic;

begin
	UUT: entity work.alu
	port map(a=>a, b=>b, result=>result, ALUControl=>ALUControl, zero=>zero);
		stimulus : process
		begin
			wait for 1 ns;
			a<=num1;
			b<=num2;
			assert(result=0);
			stop;
		end process stimulus;
end test;
