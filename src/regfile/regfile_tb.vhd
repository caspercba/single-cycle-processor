library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

library work;
use work.logger.log;
use work.operations.all;

entity regfile_tb is
end regfile_tb;

architecture test of regfile_tb is
	constant half_period	: time :=5 ns;
	
	component regfile is
	port(
		clk	: in std_logic;
		we3	: in std_logic;
		ra1	: in std_logic_vector(4 downto 0);
		ra2	: in std_logic_vector(4 downto 0);
		wa3	: in std_logic_vector(4 downto 0);
		wd3	: in data_bus;
		rd1	: out data_bus;
		rd2	: out data_bus
);
	end component regfile;

	signal clk, we3		: std_logic := '0';
	signal ra1, ra2, wa3	: std_logic_vector(4 downto 0);
	signal wd3, rd1, rd2	: data_bus;
	signal current_reg	: integer := 0;

begin
	dut	: entity work.regfile
	port map(clk=>clk, we3=>we3, ra1=>ra1, ra2=>ra2, wa3=>wa3, wd3=>wd3, rd1=>rd1, rd2=>rd2);

		clk_process: process(clk)
		begin
			clk <= not clk after half_period;
		end process clk_process;

		stimulus: process
		begin
			for i in 0 to 30 loop
				wait until rising_edge(clk);
				ra1<=std_logic_vector(to_unsigned(i, ra1'length));
				ra2<=std_logic_vector(to_unsigned(i, ra2'length));
				wait until falling_edge(clk); 
				assert rd1=std_logic_vector(to_unsigned(i, rd1'length));
				assert rd2=std_logic_vector(to_unsigned(i, rd2'length));
				log("Checking register D1: " & to_string(i) & " result is: " & to_hex_string(rd1));
				log("Checking register D2: " & to_string(i) & " result is: " & to_hex_string(rd2));
			end loop;
			wait until rising_edge(clk);
			
			ra1<=std_logic_vector(to_unsigned(31, ra1'length));
			ra2<=std_logic_vector(to_unsigned(31, ra2'length));
		
			wait until falling_edge(clk);
			log("Checking register 31");
			assert rd1 = (rd1'range => '0')
			report "RD1, expected:  0\nRD1 got: " & to_hex_string(rd1) severity error;
			assert rd2= (rd2'range => '0')
			report "RD2, expected: 0. Got: " & to_hex_string(rd2) severity error;
			wa3<="00000";
			wd3<=std_logic_vector(to_unsigned(100, wd3'length));
			we3<='1';
			wait until rising_edge(clk);
			ra1<="00000";
			wait until falling_edge(clk);
			assert rd1=std_logic_vector(to_unsigned(100, rd1'length))
			report "Writing 100 onto 00000 failed. Got: " & to_hex_string(rd1) severity error;	
			we3<='0';
			wd3<=std_logic_vector(to_unsigned(200, wd3'length));
			ra1<="00000";
			wait until falling_edge(clk);
			log("Testing write is disabled when we3 is 0");
			assert rd1=std_logic_vector(to_unsigned(100, rd1'length))
			report "Writing 200 onto 00000 should still return 100 when we3 is 0. Got: " & to_hex_string(rd1) severity error;	
			stop;

		end process stimulus;

			
end architecture;


