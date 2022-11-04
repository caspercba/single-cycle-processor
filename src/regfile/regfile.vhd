library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
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
end entity regfile;

architecture behavioural of regfile is
	-- signals or constants here
	type reg is array(31 downto 0) of std_logic_vector(63 downto 0);
	
	function init_reg return reg is
		variable result: reg;
	begin
		for i in reg'range loop 
			result(i) := std_logic_vector(to_unsigned(i, result(i)'length));
		end loop;
		result(31) := (result(31)'range => '0');
		return result;
	end function init_reg;

	signal r	: reg := init_reg;

begin

	process(ra1)
	begin				
		rd1 <= r(to_integer(unsigned(ra1)));
	end process;

	process(ra2)
	begin
		rd2 <= r(to_integer(unsigned(ra2)));
	end process;

end architecture;
	
