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


	subtype param is std_logic_vector(63 downto 0);

	constant num_zero: param:= x"0000000000000000";
	constant num_one : param:= x"0000000000000001";
	constant num_two : param:= x"0000000000000002";
	constant num_three : param:= x"0000000000000003";
	constant num_four : param:= x"0000000000000004";
	constant neg_one : param:= x"FFFFFFFFFFFFFFFE";
	constant num_max : param:= x"FFFFFFFFFFFFFFFF";
	constant num_100 : param:= x"0000000000000000";

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
		ALUControl	: std_logic_vector(3 downto 0);
		a,b,result	: param;
		zero		: std_logic;
	end record;

	type test_data is array (natural range<>) of test_vector;

	constant tests: test_data := (
	(CTRL_AND, num_zero, num_zero, num_zero,'1'),
	(CTRL_AND, num_one, num_one, num_one, '0'),
	(CTRL_AND, num_one, num_three, num_one, '0'), 
	(CTRL_ADD, num_one, num_one, num_two, '0'),
	(CTRL_ADD, num_one, neg_one, num_zero, '1')	
);

begin
	UUT: entity work.alu
	port map(a=>a, b=>b, result=>result, ALUControl=>ALUControl, zero=>zero);
		stimulus : process
			variable expected: std_logic_vector(63 downto 0);
		begin
			wait for 10 ns;
			for i in tests'range loop
				report "Testing " & integer'image(i);
				a<=tests(i).a;
				b<=tests(i).b;
				ALUControl<=tests(i).ALUControl;
				wait for 100 ns;
				assert(result = tests(i).result);
				report "result: " & to_hex_string(result)
				severity error;
			--assert(zero = tests(i).zero);
			end loop;
			stop;
		end process stimulus;
end test;
