library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.stop;
library work;
use work.alu_helper.ALL;

entity alu_tb is
end alu_tb;

architecture test of alu_tb is
	
	constant num1: integer :=-50;
	constant num2: integer :=-50;
	constant num_max: std_logic_vector(63 downto 0) := x"FFFFFFFFFFFFFFFF";  

	component alu is
		port(
		a,b		: in std_logic_vector(63 downto 0);
		ALUControl	: in std_logic_vector(3 downto 0);
		result		: out std_logic_vector(63 downto 0);
		zero		: out std_logic
	);
	end component alu;
	
	signal a,b,result: std_ulogic_vector(63 downto 0);
	signal ALUControl: std_logic_vector(3 downto 0);
	signal zero	 : std_logic;

begin
	UUT: entity work.alu
	port map(a=>a, b=>b, result=>result, ALUControl=>ALUControl, zero=>zero);
		stimulus : process
			variable expected: std_logic_vector(63 downto 0);
		begin
			wait for 1 ns;
			a<=std_ulogic_vector(to_signed(num1, a'length));
			b<=std_ulogic_vector(to_signed(num2, b'length));
			ALUControl<=CTRL_ADD;
			expected := (others => '0');
			wait for 1 ns;
			assert(result = expected);
			wait for 1 ns;
			stop;
		end process stimulus;
end test;
