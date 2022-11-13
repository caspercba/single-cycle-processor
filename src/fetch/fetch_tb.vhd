library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;
use ieee.numeric_std.all;

library work;
use work.logger.all;
use work.ss_math.all;
use work.operations.all;

entity fetch_tb is
end fetch_tb;

architecture test of fetch_tb is
	signal PCSrc_f, clk		:	std_logic := '0';
	signal reset			:	std_logic := '1';
	signal PCBranch_F, imem_addr_F 	:	data_bus;
	
	constant half_period	:	time := 5 ns;
	constant DEC_200: data_bus := int_to_vec(200, data_bus'length);
	
begin
	dut : entity work.fetch
	port map(PCSrc_F => PCSrc_F, clk => clk, reset => reset, PCBranch_F => PCBranch_F, imem_addr_F => imem_addr_F);

	clk_process: process(clk)
	begin
		clk <= not clk after half_period;
	end process clk_process;
	
	stimulus : process
		variable clock_count: integer := 0;
		variable last_pc	:	data_bus;
	begin
		wait for 10 ps;
		if(clock_count=5) then
			reset<='0';
		end if;
		if rising_edge(clk) then
			wait for 1 ns;
			if clock_count < 5 then
				checkZeroes(imem_addr_F, "fetch_tb:: Testing PC initial value is zero");
				PCBranch_F <= DEC_200;
				last_pc:=imem_addr_F;
			elsif clock_count = 20 then
				PCSrc_F <= '1';
				last_pc := DEC_200; 
			elsif clock_count = 21 then
				checkEqual(DEC_200, imem_addr_F, "fetch_tb:: Check that PCBranch_F is now being used after PCSrc_F is ON");
				PCSrc_F <= '0';
				last_pc:=imem_addr_F;
			elsif clock_count >= 5 then
				checkEqual(vec_add(last_pc, 4),imem_addr_F, "fetch_tb:: Testing PC increments by +4");
				last_pc:=imem_addr_F;
			end if;

			clock_count:=clock_count + 1;
		end if;
		if clock_count > 100 then
			stop;
		end if;
	end process;
end architecture;
			
					
	
