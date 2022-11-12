library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity fetch is port(
			PCSrc_F	:	in std_logic;
			clk	:	in std_logic;
			reset	:	in std_logic;
			PCBranch_F	:	in data_bus; 
			imem_addr_F	:	out data_bus 
			);
end entity fetch;

architecture behavioural of fetch is
	
	signal Add_output_to_Mux_d_in0	:	data_bus;	
	signal MUX_out_to_PC		:	data_bus;	
	
begin
	PC : entity work.flopr 
	port map(
		clk	=>	clk,
		reset	=>	reset,
		d	=>	MUX_out_to_PC,
		q	=>	imem_addr_F
	);
	MUX : entity work.mux port map(
		d_in0	=>	Add_output_to_Mux_d_in0,
		d_in1	=>	PCBranch_F,
		d_out	=>	MUX_out_to_PC,
		selector=>	PCSrc_F
	);	
	Add : entity work.alu port map(
		a	=>	imem_addr_F,
		b	=>	int_to_vec(4, data_bus'length),
		ALUControl=>	ADD_HEX,	
		result	=>	Add_output_to_Mux_d_in0
	);
			
	

end architecture;
