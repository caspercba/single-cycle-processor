
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.operations.all;

entity maindec is
	port(
	Op	: in std_logic_vector(10 downto 0);
	RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out std_logic;
	ALUOp	: out std_logic_vector(1 downto 0)
);
end entity maindec;

architecture behavioural of maindec is
	-- signals or constants here
begin

	with Op select
	RegToLoc <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR,
		    	'1' when OP_STUR|OP_CBZ_COMPAT,
		    	'0' when others;
	
	with Op select
	ALUSrc <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_CBZ_COMPAT,
		    '1' when OP_LDUR|OP_STUR,
		    '0' when others;

	with Op select
	MemToReg <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_STUR|OP_CBZ_COMPAT,
		    '1' when OP_LDUR,
		    '0' when others;

	with Op select
	RegWrite <= '1' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR,
		    '0' when OP_STUR|OP_CBZ_COMPAT,
		    '0' when others;

	with Op select
	MemRead <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_STUR|OP_CBZ_COMPAT,
		   '1' when OP_LDUR,
		   '0' when others;

	with Op select
	MemWrite <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR|OP_CBZ_COMPAT,
		   	'1' when OP_STUR,
		   	'0' when others;

	with Op select
	Branch <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR|OP_STUR,
		   	'1' when OP_CBZ_COMPAT,
		   	'0' when others;

	with Op select
	ALUOp <= 	"10" when OP_ADD|OP_SUB|OP_AND|OP_ORR,
		   	"00" when OP_LDUR|OP_STUR,
		   	"01" when OP_CBZ_COMPAT,
		   	"00" when others;


end architecture;

