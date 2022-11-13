library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity datapath is port(
	AluControl		:	in std_logic_vector(3 downto 0) := (others => '0');
	AluSrc			:	in std_logic := '0';
	memtoReg		:	in std_logic := '0';
	reg2loc			:	in std_logic := '0';
	regWrite		:	in std_logic := '0';
	Branch			:	in std_logic := '0';
	memRead			:	in std_logic := '0';
	memWrite		:	in std_logic := '0';
	reset			:	in std_logic := '0';
	clk			:	in std_logic := '0';
	IM_readData		:	in std_logic_vector(31 downto 0) := (others => '0');
	DM_readData		:	in data_bus := (others => '0');
	DM_writeEnable		:	out std_logic := '0';
	DM_readEnable		:	out std_logic := '0';
	IM_addr			:	out data_bus := (others => '0');
	DM_addr			:	out data_bus := (others => '0');
	DM_writeData		:	out data_bus := (others => '0')
);
end entity datapath;

architecture behavioural of datapath is
	signal PCSrc_bus		: std_logic := '0';
	signal PCBranch_bus		: data_bus := (others => '0');
	signal IM_addr_bus		: data_bus := (others => '0');
	signal writeData3_bus		: data_bus := (others => '0');
	signal signImm_bus		: data_bus := (others => '0');
	signal readData1_bus		: data_bus := (others => '0');
	signal readData2_bus		: data_bus := (others => '0');
	signal zero_bus			: std_logic := '0';
	signal DM_addr_bus		: data_bus := (others => '0');
	
begin
	fetch : entity work.fetch port map(
		PCSrc_F		=>	PCSrc_bus,
		clk		=>	clk,
		reset		=>	reset,
		PCBranch_F	=>	PCBranch_bus,
		imem_addr_F	=>	IM_addr_bus
	);

	decode : entity work.decode port map(
		reg2loc_D	=>	reg2loc,
		regWrite_D	=>	regWrite,
		clk		=>	clk,
		writeData3_D	=>	writeData3_bus,
		instr_D		=>	IM_readData,
		signImm_D	=>	signImm_bus,
		readData1_D	=>	readData1_bus,
		readData2_D	=>	readData2_bus
	);

	execute : entity work.execute port map(	
		aluSrc		=>	AluSrc,
		aluControl	=> 	AluControl,
		PC_E		=>	IM_addr_bus,
		signImm_E	=>	signImm_bus,
		readData1_E	=>	readData1_bus,
		readData2_E	=>	readData2_bus,
		PCBranch_E	=>	PCBranch_bus,
		aluResult_E	=>	DM_addr_bus,
		writeData_E	=>	DM_writeData,
		zero_E		=>	zero_bus
	);

	memory : entity work.memory port map(
		Branch_M	=>	Branch,
		zero_M		=>	zero_bus,
		PCSrc_M		=>	PCSrc_bus
	);

	writeback : entity work.writeback port map(
		memtoReg	=>	memtoReg,
		aluResult_W	=>	DM_addr_bus,
		DM_readData_W	=>	DM_readData,
		writeData3_W	=>	writeData3_bus
	);	

	IM_addr <= IM_addr_bus;
	DM_addr <= DM_addr_bus;

end architecture;
	
