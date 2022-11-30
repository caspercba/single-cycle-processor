library ieee;
use ieee.std_logic_1164.all;

library work;

entity processor_arm is port (
	reset		:	in	std_logic := '0';
	clk		:	in	std_logic := '0';
	dump		:	in	std_logic
);

architecture behavioural of processor_arm is
	signal 	clk_bus	: std_logic := '0';
	signal instr_bus: std_logic_vector(31 downto 0):=(others => '0');
	signal AluControl_bus: std_logic_vector(3 downto 0):=(others => '0');
	signal AluSrc_bus : std_logic := '0';
	signal memtoReg_bus : std_logic := '0';
	signal reg2loc_bus : std_logic := '0';
	signal regWrite_bus : std_logic := '0';
	signal Branch_bus : std_logic := '0';
	signal memRead_bus : std_logic := '0';
	signal memWrite_bus : std_logic := '0';
	signal DM_writeEnable_bus : std_logic := '0';
	signal DM_readEnable_bus : std_logic := '0';
	signal IM_addr_bus : data_bus := (others => '0');
	signal IM_readData_bus: std_logic_vector(31 downto 0):=(others=>'0');
	signal DM_addr_bus: data_bus := (others => '0');
	signal DM_writeData_bus : data_bus := (others => '0');
	signal DM_readData_bus : data_bus := (others => '0');

begin
	controller : entity work.controller port map(
		instr		=>	instr_bus(31 downto 21),
		AluControl	=>	AluControl_bus,
		AluSrc		=>	AluSrc_bus,
		memtoReg	=>	memtoReg_bus,
		reg2loc		=>	reg2loc_bus,
		regWrite	=>	regWrite_bus,
		Branch		=>	Branch_bus,
		memRead		=>	memRead_bus,
		memWrite	=>	memWrite_bus
	);

	datapath : entity work.datapath port map(
		reset		=>	reset,
		clk		=> 	clk_bus,
		AluControl	=>	AluControl_bus,
		AluSrc		=>	AluSrc_bus,
		memtoReg	=>	memtoReg_bus,
		reg2loc		=>	reg2loc_bus,
		regWrite	=>	regWrite_bus,
		Branch		=>	Branch_bus,
		memRead		=>	memRead_bus,
		memWrite	=>	memWrite_bus,
		DM_writeEnable	=>	DM_writeEnable_bus,
		DM_readEnable	=>	DM_readEnable_bus,
		IM_addr		=>	IM_addr_bus,
		IM_readData	=>	IM_readData_bus,
		DM_addr		=>	DM_addr_bus,
		DM_writeData	=>	DM_writeData_bus,
		DM_readData	=>	DM_readData_bus
	);

	imem : entity work.imem port map(
		addr	=>	IM_addr_bus(7 downto 2),
		q	=>	IM_readData_bus
	);







	
