library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.operations.all;

entity decode is port(
	reg2loc_D	: 	in std_logic := '0';
	regWrite_D	: 	in std_logic := '0';
	clk		: 	in std_logic := '0';
	writeData3_D	:	in data_bus := (others => '0');
	instr_D		:	in std_logic_vector(31 downto 0);
	signImm_D	:	out data_bus := (others => '0');
	readData1_D	:	out data_bus := (others => '0');
	readData2_D	:	out data_bus := (others => '0')
);
end entity decode;

architecture behavioural of decode is
	signal instr_D_bus	: std_logic_vector(31 downto 0) := (others => '0');
	signal reg_ra2_bus	: std_logic_vector(4 downto 0) := (others => '0');
begin
	signext : entity work.signext port map(
		a	=>	instr_D_bus,
		y	=>	signImm_D
	);

	mux : entity work.mux 
	generic map(datawidth => 5)	
	port map(
		selector	=>	reg2loc_D,
		d_in0		=>	instr_D_bus(20 downto 16),
		d_in1		=>	instr_D_bus(4 downto 0),
		d_out		=>	reg_ra2_bus
	);
	
	registers : entity work.regfile port map(
		clk		=>	clk,
		we3		=>	regWrite_D,
		ra1		=>	instr_D_bus(9 downto 5),
		ra2		=>	reg_ra2_bus,
		wa3		=>	instr_D_bus(4 downto 0),
		wd3		=>	writeData3_D,
		rd1		=>	readData1_D,
		rd2		=>	readData2_D
	);	

	instr_D_bus <= instr_D;
		
end architecture;
