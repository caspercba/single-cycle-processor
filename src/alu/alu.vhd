library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use std.textio.all;
library work;
use work.alu_helper.ALL;




entity alu is
	port(
	a,b		: in std_ulogic_vector(63 downto 0);
	ALUControl	: in std_logic_vector(3 downto 0);
	result		: out std_logic_vector(63 downto 0);
	zero		: out std_logic
);
end alu;


architecture behavioural of alu is

		signal temp: std_logic_vector(64 downto 0);
	--alias D_address_sign is a(20);
	--alias CB_address_sign is a(23);
begin
	process(a,b,ALUControl)
	begin
		if(ALUControl=CTRL_AND) then
			result<=a and b;
		elsif(ALUControl=CTRL_OR) then
			result<=a or b;
		elsif(ALUControl=CTRL_ADD) then
			result<=a xor b;
		elsif(ALUControl=CTRL_SUB) then
			result<=a xor not b;
		elsif(ALUControl=CTRL_PASS) then
			result<=b;
		elsif(ALUControl=CTRL_NOR) then
			result<=a nor b;
		else
			result<=(others=>'0');
		end if;
end process;
end behavioural;

