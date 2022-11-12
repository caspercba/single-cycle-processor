library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use std.textio.all;
use std.env.stop;
use work.operations.all;

entity signext_tb is
end signext_tb;

architecture test of signext_tb is
	component signext
	port(
	a		: in std_logic_vector(31 downto 0);
	y		: out data_bus
	);
	end component;

	subtype D_EXPECTED_HEAD_RANGE is integer range 63 downto D_ADDR_SIZE;
	subtype D_EXPECTED_ADDR_RANGE is integer range D_ADDR_SIZE-1 downto 0;
	subtype CB_EXPECTED_HEAD_RANGE is integer range 63 downto CB_ADDR_SIZE;
	subtype CB_EXPECTED_ADDR_RANGE is integer range CB_ADDR_SIZE-1 downto 0;

	constant test1:std_logic_vector(31 downto 0) := build_D_instruction(OP_LDUR, "001001111");
	constant test2:std_logic_vector(31 downto 0) := build_D_instruction(OP_LDUR, "110100111");
	constant test3:std_logic_vector(31 downto 0) := build_D_instruction(OP_STUR, "011111110");
	constant test4:std_logic_vector(31 downto 0) := build_D_instruction(OP_STUR, "100000001");
	constant test5:std_logic_vector(31 downto 0) := build_CB_instruction(OP_CBZ, "0000001111110000000");
	constant test6:std_logic_vector(31 downto 0) := build_CB_instruction(OP_CBZ, "1010101010101010101");
	constant test7:std_logic_vector(31 downto 0) := build_R_instruction(OP_ADD);
	
	constant out1: data_bus:= (D_EXPECTED_HEAD_RANGE => '0', D_EXPECTED_ADDR_RANGE => "001001111");
	constant out2: data_bus:= (D_EXPECTED_HEAD_RANGE => '1', D_EXPECTED_ADDR_RANGE => "110100111");
	constant out3: data_bus:= (D_EXPECTED_HEAD_RANGE => '0', D_EXPECTED_ADDR_RANGE => "011111110");
	constant out4: data_bus:= (D_EXPECTED_HEAD_RANGE => '1', D_EXPECTED_ADDR_RANGE => "100000001");
	constant out5: data_bus:= (CB_EXPECTED_HEAD_RANGE => '0', CB_EXPECTED_ADDR_RANGE => "0000001111110000000");
	constant out6: data_bus:= (CB_EXPECTED_HEAD_RANGE => '1', CB_EXPECTED_ADDR_RANGE => "1010101010101010101");
	constant out7: data_bus:= (others=>'0');
	
	signal a: std_logic_vector(31 downto 0);
	signal y: data_bus;

begin
	UUT: entity work.signext
	port map(a=>a, y=>y);
		stimulus : process
		begin
			wait for 10 ns;
			a <= test1;
			wait for 1 ns;
			report "expected: " & to_string(out1(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out1);
			wait for 5 ns;
			a <= test2;
			wait for 1 ns;
			report "expected: " & to_string(out2(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out2);
			wait for 5 ns;
			a <= test3;
			wait for 1 ns;
			report "expected: " & to_string(out3(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out3);
			wait for 5 ns;
			a <= test4;
			wait for 1 ns;
			report "expected: " & to_string(out4(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out4);
			wait for 5 ns;
			a <= test5;
			wait for 1 ns;
			report "test    : " & to_string(test5(31 downto 0));
			report "expected: " & to_string(out5(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out5);
			wait for 5 ns;
			a <= test6;
			wait for 1 ns;
			report "expected: " & to_string(out6(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out6);
			wait for 5 ns;
			a <= test7;
			wait for 1 ns;
			report "expected: " & to_string(out7(63 downto 0));
			report "result  : " & to_string(y(63 downto 0));
			assert(y=out7);
			wait for 5 ns;
			stop;
		end process stimulus;
end test;
