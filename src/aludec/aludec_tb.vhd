library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

library work;

entity aludec_tb is
end aludec_tb;

architecture test of aludec_tb is
	signal instr	:	std_logic_vector(10 downto 0) := (others => '0');
       	signal ALUOp	: 	std_logic_vector(1 downto 0) := (others => '0');
	signal AluControl	:	std_logic_vector(3 downto 0) := (others => '0');       
begin
dut : entity work.aludec port map(
	ALUOp		=>	ALUOp,
	instr		=>	instr,
	AluControl	=>	AluControl
);

stimulus : process
begin
	stop;
end process stimulus;
end architecture;
