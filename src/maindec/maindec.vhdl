
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;

entity maindec is
	port(
	Op	: in std_logic_vector(10 downto 0);
	RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out std_logic;
	ALUOp	: out std_logic_vector(1 downto 0)
);
end entity maindec;

architecture behavioural of maindec is
	-- signals or constants here
	--type reg is array(31 downto 0) of std_logic_vector(63 downto 0);
	
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

	process(ra1, ra2, clk, wa3, wd3, we3)
	begin			
	end process;
end architecture;	
