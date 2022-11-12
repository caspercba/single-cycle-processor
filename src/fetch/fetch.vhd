library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;

entity fetch is port(
			PCSrc_F	:	in std_logic;
			clk	:	in std_logic;
			reset	:	in std_logic;
			PCBranch_F	:	in std_logic_vector(63 downto 0);
			imem_addr_F	:	out std_logic_vector(63 downto 0)
			);
end entity fetch;

architecture behavioural of fetch is

	signal Add_output_to_Mux_d_in0	:	std_logic_vector(63 downto 0);
	signal MUX_out_to_PC		:	std_logic_vector(63 downto 0);
	
	component flopr port(
		clk, reset	: in std_logic;
		d, q		: in std_logic_vector(datawidth - 1 downto 0)
	);
	end component;
	component alu port(
		a,b		: in std_ulogic_vector(63 downto 0);
		ALUControl	: in std_logic_vector(3 downto 0);
		result		: out std_logic_vector(63 downto 0);
		zero		: out std_logic
	);
	end component alu;
	component mux port(
		selector	: in	std_logic := '0';
		d_in0, d_in1	: in	bus_data;
		d_out		: out	bus_data
	);
	end component mux;
		
begin
	PC : flopr port map(
		clk	=>	clk,
		reset	=>	reset,
		d	=>	MUX_out_to_PC,
		q	=>	imem_addr_F
	);
	MUX : mux port map(
		d_in0	=>	Add_output_to_Mux_d_in0,
		d_in1	=>	PCBranch_F,
		d_out	=>	MUX_out_to_PC,
		selector=>	PCSrc_F
	);	
	Add : alu port map(
		a	=>	imem_addr_F,
		b	=>	std_logic_vector(to_unsigned(4)),
		ALUControl=>	ADD_HEX,	
		result	=>	Add_output_to_Mux_d_in0
	);
			
	

end architecture;
