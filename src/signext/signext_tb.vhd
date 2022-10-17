library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use std.textio.all;
use std.env.stop;

entity signext_tb is
end signext_tb;

architecture test of signext_tb is
	component signext
	port(
	a		: in std_logic_vector(31 downto 0);
	y		: out std_logic_vector(63 downto 0)
	);
	end component;

	constant LDUR_OP: std_logic_vector (10 downto 0):= "11111000010";
	constant LDUR_ADD :std_logic_vector(8 downto 0):= "100001111";
	constant LDUR_OTHER :std_logic_vector(11 downto 0):= "000000000000";
	signal LDUR :std_logic_vector(31 downto 0):= LDUR_OP & LDUR_ADD & LDUR_OTHER;
	signal zeros: std_logic_vector(63 downto 0):=(others=>'0');
	signal a: std_logic_vector(31 downto 0);
	signal y: std_logic_vector(63 downto 0);
begin
	UUT: entity work.signext
	port map(a=>a, y=>y);
		 stimulus : process
		 begin
			 wait for 10 ns;
		report "INPUT: " & to_string(LDUR);
		a<=LDUR;
		wait for 1 ns;
		report "last 9 bits: " & to_string(y(8 downto 0));
		report "first 55 bits: " &to_string (y(63 downto 0));
		assert(y(8 downto 0)=LDUR_ADD);
		assert(y(63 downto 9)=zeros(54 downto 0));
		--report "END";
		stop;
end process stimulus;
end test;