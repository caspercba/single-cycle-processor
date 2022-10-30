library ieee;
use ieee.std_logic_1164.all;

library work;
use work.logger.log;

use std.env.stop;

entity imem_tb is
end imem_tb;

architecture test of imem_tb is
	constant datawidth 	: integer := 32;
	
	component imem is
	port(
		addr	: in std_logic_vector(5 downto 0);
		q	: out std_logic_vector(datawidth - 1 downto 0)
	);
	end component imem;

	signal addr	: std_logic_vector(5 downto 0);
	signal q	: std_logic_vector(31 downto 0);

	type test_vector is record
		addr	: std_logic_vector(addr'range);
		q	: std_logic_vector(q'range);
	end record;

	type test_data is array (natural range<>) of test_vector;

	constant tests: test_data := (
	("000000", x"f8000000"),
	("000001", x"f8008001"),
	("000010", x"f8010002"),
	("000011", x"f8018003"),
	("000100", x"f8020004"),
	("000101", x"f8028005"),
	("000110", x"f8030006"),
	("000111", x"f8400007"),
	("001000", x"f8408008"),
	("001001", x"f8410009"),
	("001010", x"f841800a"),
	("001011", x"f842000b"),
	("001100", x"f842800c"),
	("001101", x"f843000d"),
	("001110", x"cb0e01ce"),
	("001111", x"b400004e"),
	("010000", x"cb01000f"),
	("010001", x"8b01000f"),
	("010010", x"f803800f"),
	("010011", x"00000000"),
	("010100", x"00000000"),
	("010101", x"00000000"),
	("010110", x"00000000"),
	("010111", x"00000000"),
	("011000", x"00000000")
);
		



begin
	UUT: entity work.imem
	generic map(datawidth=>datawidth)
	port map(addr=>addr, q=>q);
	
		 stimulus: process
		 begin
			 wait for 10 ns;
			 for i in tests'range loop
				addr <= tests(i).addr;
				wait for 100 ns;
				assert(q = tests(i).q)
				report "Addr: " & to_string(tests(i).addr) & ", expected: " & to_hex_string(tests(i).q) & " but was: " & to_hex_string(q) severity error;
			end loop;
			stop;
		end process stimulus;
end test;
