library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.stop;
library work;
use work.alu_helper.all;
use work.ss_math.all;
use work.logger.all;

entity alu_tb is
end alu_tb;

architecture test of alu_tb is


	subtype param is std_logic_vector(63 downto 0);

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
	
	type test_vector is record
		op		: alu_op;
		a		: integer;
		b		: integer;
		result		: integer;
		zero		: std_logic;
	end record;

	type test_data is array (natural range<>) of test_vector;

	constant num_max	:std_logic_vector:= x"FFFFFFFFFFFFFFFF";
	constant tests: test_data := (
	(A_AND, 150, 100, 4, '0'),
	(A_AND, -150, 100, 96, '0'),
	(A_AND, -150, -100, -248, '0'),
	(A_OR, 150, 100, 246, '0'),
	(A_OR, -150, 100, -146, '0'),
	(A_OR, -150, -100, -2, '0'),
	(A_ADD, 150, 100, 250, '0'),
	(A_ADD, -150, 100, -50, '0'),
	(A_ADD, -150, -100, -250, '0'),
	(A_SUB, 150, 100, 50, '0'),
	(A_SUB, -150, 100, -250, '0'),
	(A_SUB, -150, -100, -50, '0'),
	(A_PASS, 150, 100, 100, '0'),
	(A_PASS, -150, 100, 100, '0'),
	(A_PASS, -150, -100, -100, '0'),
	(A_NOR, 150, 100, -247, '0'),
	(A_NOR, -150, 100, 145, '0'),
	(A_NOR, -150, -100, 1, '0'),
	(A_NONE, -150, -100, 0, '1'),
	(A_ADD, -150123, 150123, 0, '1'),
	(A_ADD, 0, 0, 0, '1'),
	(A_ADD, to_integer(signed(num_max)), 1, 0, '1')
);

begin
	UUT: entity work.alu
	port map(a=>a, b=>b, result=>result, ALUControl=>ALUControl, zero=>zero);
		stimulus : process
			variable expected: std_logic_vector(63 downto 0);
		begin
			wait for 10 ns;
			for i in tests'range loop
				log("----- Alu testcase #" & to_string(i+1) & "of " & to_string(tests'length) & "-----");
				a<=int_to_vec(tests(i).a, 64);
				b<=int_to_vec(tests(i).b, 64);
				ALUControl<=op_to_vector(tests(i).op);
				wait for 100 ns;
				assert(result = int_to_vec(tests(i).result, 64) and zero = tests(i).zero)
				report "expected: " & to_hex_string(int_to_vec(tests(i).result, 64)) & "(zero= " & to_string(tests(i).zero) & ", but was: " & to_hex_string(result) & "(zero=" & to_string(zero) & ")" severity error; 
				
			end loop;
			stop;
		end process stimulus;
end test;
