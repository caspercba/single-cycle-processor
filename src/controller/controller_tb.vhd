library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

library work;

entity controller_tb is
end controller_tb;

architecture test of controller_tb is
	signal instr : std_logic_vector(10 downto 0) := (others => '0');
	signal reg2loc : std_logic := '0';
	signal AluSrc : std_logic := '0';
	signal memtoReg : std_logic := '0';
	signal regWrite : std_logic := '0';
	signal memRead : std_logic := '0';
	signal memWrite : std_logic := '0';
	signal Branch : std_logic := '0';
	signal AluControl : std_logic_vector(3 downto 0) := (others => '0');
begin
	dut : entity work.controller port map(
		instr 		=> 	instr,
		reg2loc 	=> 	reg2loc,
		AluSrc 		=> 	AluSrc,
		memtoReg 	=> 	memtoReg,
		regWrite 	=> 	regWrite,
		memRead		=>	memRead,
		memWrite	=>	memWrite,
		Branch		=>	Branch,
		AluControl	=>	AluControl
	);

	stimulus : process
	begin
		stop;
	end process stimulus;
end architecture;
		

