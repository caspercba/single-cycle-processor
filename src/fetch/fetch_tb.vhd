library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;
use ieee.numeric_std.all;

library work;
use work.logger.log;

entity fetch_tb is
end fetch_tb;

architecture test of fetch_tb is
	signal PCSrc_f, clk, reset	:	std_logic := '0';
	signal PCBranch_F, imem_addr_F	:	std_logic_vector(63 downto 0);
	
	constant half_period	:	time := 5 ns;
	component fetch port(
		PCSrc_F, clk, reset	:	in std_logic;
		PCBranch_F, imem_addr_F	:	in std_logic_vector(63 downto 0)
	);
	end component fetch;
	
begin
	dut : entity work.fetch
	port map(PCSrc_F => PCSrc_F, clk => clk, reset => reset, PCBranch_F => PCBranch_F, imem_addr_F => imem_addr_F);

	clk_process: process(clk)
	begin
		clk <= not clk after half_period;
	end process clk_process;
	
	stimulus : process
		variable clock_count: integer := 0;
		variable last_pc	:	std_logic_vector(63 downto 0);
	begin
		wait;
		if(clock_count>=5) then
			reset<='0';
		else 
			reset<='1';
		end if;
		if rising_edge(clk) then
			if clock_count = 5 then
				assert to_integer(imem_addr_F) = to_integer(last_pc) + 4;
			end if;
			if clock_count > 5 then
				assert to_integer(imem_addr_F) = 0;
			end if;
			if clock_count < 10 then
				clock_count:=clock_count + 1;
			end if;
			last_pc:=imem_addr_F;
		end if;
	end process;
end architecture;
			
					
	
