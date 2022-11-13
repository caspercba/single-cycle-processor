library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity fetch is port(
			PCSrc_F, clk	:	in std_logic := '0';
			reset		:	in std_logic := '1';
			PCBranch_F	:	in data_bus := (others => '0'); 
			imem_addr_F	:	out data_bus := (others => '0') 
			);
end entity fetch;

architecture behavioural of fetch is
	
	signal Add_output_to_Mux_d_in0	:	data_bus := (others => '0');	
	signal MUX_out_to_PC		:	data_bus := (others => '0');	
	signal PC_output		:	data_bus := (others => '0');
	
begin
	PC : entity work.flopr 
	port map(
		clk	=>	clk,
		reset	=>	reset,
		d	=>	MUX_out_to_PC,
		q	=>	PC_output	
	);
	MUX : entity work.mux port map(
		d_in0	=>	Add_output_to_Mux_d_in0,
		d_in1	=>	PCBranch_F,
		d_out	=>	MUX_out_to_PC,
		selector=>	PCSrc_F
	);	
	Add : entity work.alu port map(
		a	=>	PC_output,
		b	=>	int_to_vec(4, data_bus'length),
		ALUControl=>	ADD_HEX,	
		result	=>	Add_output_to_Mux_d_in0
	);
	imem_addr_F <= PC_output;
			
	

end architecture;
