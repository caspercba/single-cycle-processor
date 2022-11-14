library ieee;
use ieee.std_logic_1164.all;

library work;
use work.logger.all;
use work.alu_helper.all;
use work.operations.all;

entity aludec is port(
	ALUOp		:	in std_logic_vector(1 downto 0) := (others => '0');
	instr		:	in std_logic_vector(10 downto 0) := (others => '0');
	AluControl	:	out std_logic_vector(3 downto 0) := (others => '0')
);
end entity aludec;

architecture behavioural of aludec is
begin
	if ALUOp = "00" then
		AluControl <= ADD_HEX;
	elsif ALUOp = "01" then
		AluControl <= PASS_HEX;
	else
		case instr is
			when OP_ADD => AluControl <= ADD_HEX;
		       	when OP_SUB => AluControl <= SUB_HEX;
			when OP_AND => AluControl <= AND_HEX;
			when OP_ORR => AluControl <= OR_HEX;
			when others => AluControl <= ADD_HEX;
		end case;
	end if;
end architecture;
			
