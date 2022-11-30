library ieee;
use ieee.std_logic_1164.all;

entity controller is port(
	instr		:	in std_logic_vector(10 downto 0) := (others => '0');
	reg2loc		:	out std_logic := '0';
	AluSrc		:	out std_logic := '0';
	memtoReg	:	out std_logic := '0';
	regWrite	:	out std_logic := '0';
	memRead		:	out std_logic := '0';
	memWrite	:	out std_logic := '0';
	Branch		:	out std_logic := '0';
	AluControl	:	out std_logic_vector(3 downto 0) := (others => '0')
);
end entity controller;

architecture behavioural of controller is
	signal instr_bus	:	std_logic_vector(10 downto 0) := (others => '0');
	signal ALUOp_bus	:	std_logic_vector(1 downto 0) := (others => '0');
begin
	aludec : entity work.aludec port map(
		ALUOp		=>	ALUOp_bus,
		instr		=>	instr_bus,
		AluControl	=>	AluControl
	);

	maindec : entity work.maindec port map(
		instr		=>	instr_bus,
		ALUOp		=>	ALUOp_bus,
		reg2loc		=>	reg2loc,
		AluSrc		=>	AluSrc,
		memtoReg	=>	memtoReg,
		regWrite	=>	regWrite,
		memRead		=>	memRead,
		memWrite	=>	memWrite,
		Branch		=>	Branch
	);
	instr_bus <= instr;
end architecture;

