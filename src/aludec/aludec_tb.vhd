library ieee;
use ieee.std_logic_1164.all;

library work;
use work.alu_helper.all;
use work.operations.all;

entity aludec_tb is
end aludec_tb;

architecture test of aludec_tb is
	signal ALUOp	:	std_logic_vector(1 downto 0) := (others => '0');
	signal instr	: 	std_logic_vector	
begin
	uut : entity work.aludec port map(
		ALUOp		=>	ALUOp,
		instr		=>	instr,
		AluControl	=>	AluControl
	);
end architecture;
