library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;

entity writeback is port(
	memtoReg	:	std_logic := '0';
	aluResult_W	:	in data_bus := (others => '0');
	DM_readData_W	:	in data_bus := (others => '0');
	writeDadta3_W	:	out data_bus := (others => '0')
);
end entity writeback;

architecture behavioural of writeback is
begin
	mux : entity work.mux port map(
		selector	=>	memtoReg,
		d_in0		=>	aluResult_W,
		d_in1		=>	DM_readData_W,
		d_out		=>	writeData3_W
	);
end architecture;
