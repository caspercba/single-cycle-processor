library ieee;
use ieee.std_logic_1164.all;


library work;
use work.alu_helper.all;
use work.operations.all;

entity aludec is port(
	ALUOp		:	in std_logic_vector(1 downto 0);
	instr		:	in std_logic_vector(10 downto 0);
	AluControl	:	out std_logic_vector(3 downto 0) 
);
end entity aludec;

architecture behavioural of aludec is
begin
	process(ALUOp, instr)
	begin
		if ALUOp = "00" then
			AluControl <= ADD_HEX;
		elsif ALUOp = "01" then
			AluControl <= PASS_HEX;
		else
			if instr = OP_ADD then AluControl <= ADD_HEX;
			elsif instr = OP_SUB then AluControl <= SUB_HEX;
			elsif instr = OP_AND then AluControl <= AND_HEX;
			elsif instr = OP_ORR then AluControl <= OR_HEX;
			else AluControl <= "0000";
			end if;
		end if;
	end process;
end architecture;
	

		 				
