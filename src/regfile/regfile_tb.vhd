library ieee;
use ieee.std_logic_1164.all;

library work;
use work.logger.log;

entity regfile_tb is
end regfile_tb;

architecture test of regfile_tb is
	component regfile is
	port(
		clk	: in std_logic;
		we3	: in std_logic;
		ra1	: in std_logic_vector(4 downto 0);
		ra2	: in std_logic_vector(4 downto 0);
		wa3	: in std_logic_vector(4 downto 0);
		wd3	: in std_logic_vector(63 downto 0);
		rd1	: out std_logic_vector(63 downto 0);
		rd2	: out std_logic_vector(63 downto 0)
);
	end component regfile;

	signal clk, we3		: std_logic;
	signal ra1, ra2, wa3	: std_logic_vector(4 downto 0);
	signal wd3, rd1, rd2	: std_logic_vector(63 downto 0);

begin
	 	

end architecture;


