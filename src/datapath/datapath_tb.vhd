library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;
use ieee.numeric_std.all;

library work;
use work.logger.all;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity datapath_tb is
end datapath_tb;

architecture test of datapath_tb is
	signal AluControl		:	std_logic_vector(3 downto 0) := (others => '0');
	signal AluSrc			:	std_logic := '0';
	signal memtoReg		:	std_logic := '0';
	signal reg2loc			:	std_logic := '0';
	signal regWrite		:	std_logic := '0';
	signal Branch			:	std_logic := '0';
	signal memRead			:	std_logic := '0';
	signal memWrite		:	std_logic := '0';
	signal reset			:	std_logic := '0';
	signal clk			:	std_logic := '0';
	signal IM_readData		:	std_logic_vector(31 downto 0) := (others => '0');
	signal DM_readData		:	data_bus := (others => '0');
	signal DM_writeEnable		:	std_logic := '0';
	signal DM_readEnable		:	std_logic := '0';
	signal IM_addr			:	data_bus := (others => '0');
	signal DM_addr			:	data_bus := (others => '0');
	signal DM_writeData		:	data_bus := (others => '0');

begin
dut : entity work.datapath port map(
	AluControl	=>	AluControl,		
	AluSrc		=>	AluSrc,	
	memtoReg	=>	memtoReg,
	reg2loc		=>	reg2loc,
	regWrite	=>	regWrite,
	Branch		=>	Branch,
	memRead		=>	memRead,
	memWrite	=>	memWrite,
	reset		=>	reset,
	clk		=>	clk,
	IM_readData	=>	IM_readData,
	DM_readData	=>	DM_readData,
	DM_writeEnable	=>	DM_writeEnable,
	DM_readEnable	=>	DM_readEnable,
	IM_addr		=>	IM_addr,
	DM_addr		=>	DM_addr,
	DM_writeData	=>	DM_writeData
);

	stimulus : process
	begin
		
		stop;
	end process;
	
end architecture;
