
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.operations.all;

entity maindec is
	port(
	instr	: in std_logic_vector(10 downto 0);
	reg2loc,ALUSrc,memtoReg,regWrite,memRead,memWrite,Branch: out std_logic;
	ALUOp	: out std_logic_vector(1 downto 0)
);
end entity maindec;

architecture behavioural of maindec is
	-- signals or constants here
begin

	with instr select
	reg2Loc <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR,
		    	'1' when OP_STUR|OP_CBZ_COMPAT,
		    	'0' when others;
	
	with instr select
	ALUSrc <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_CBZ_COMPAT,
		    '1' when OP_LDUR|OP_STUR,
		    '0' when others;

	with instr select
	memtoReg <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_STUR|OP_CBZ_COMPAT,
		    '1' when OP_LDUR,
		    '0' when others;

	with instr select
	regWrite <= '1' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR,
		    '0' when OP_STUR|OP_CBZ_COMPAT,
		    '0' when others;

	with instr select
	memRead <= '0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_STUR|OP_CBZ_COMPAT,
		   '1' when OP_LDUR,
		   '0' when others;

	with instr select
	memWrite <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR|OP_CBZ_COMPAT,
		   	'1' when OP_STUR,
		   	'0' when others;

	with instr select
	Branch <= 	'0' when OP_ADD|OP_SUB|OP_AND|OP_ORR|OP_LDUR|OP_STUR,
		   	'1' when OP_CBZ_COMPAT,
		   	'0' when others;

	with instr select
	ALUOp <= 	"10" when OP_ADD|OP_SUB|OP_AND|OP_ORR,
		   	"00" when OP_LDUR|OP_STUR,
		   	"01" when OP_CBZ_COMPAT,
		   	"00" when others;



--	case Op is
--		when OP_ADD|OP_SUB|OP_AND|OP_ORR	=> 
--				RegToLoc	<=	'0';
--				ALUSrc		<=	'0';
--				MemToReg	<=	'0';
--				RegWrite	<=	'1';
--				MemRead		<=	'0';
--				MemWrite	<=	'0';
--				Branch		<=	'0';
--				ALUOp		<=	"10";
--		when OP_LDUR	=>
--				RegToLoc	<=	'0';
--				ALUSrc		<=	'1';
--				MemToReg	<=	'1';
--				RegWrite	<=	'1';
--				MemRead		<=	'1';
--				MemWrite	<=	'0';
--				Branch		<=	'0';
--				ALUOp		<=	"00";
--		when OP_STUR	=>
--				RegToLoc	<=	'1';
--				ALUSrc		<=	'1';
--				MemToReg	<=	'0';
--				RegWrite	<=	'0';
--				MemRead		<=	'0';
--				MemWrite	<=	'1';
--				Branch		<=	'0';
--				ALUOp		<=	"00";
--		when OP_CBZ	=>
--				RegToLoc	<=	'1';
--				ALUSrc		<=	'0';
--				MemToReg	<=	'0';
--				RegWrite	<=	'0';
--				MemRead		<=	'0';
--				MemWrite	<=	'0';
--				Branch		<=	'1';
--				ALUOp		<=	"01";
--		when others	=>
--				RegToLoc	<=	'0';
--				ALUSrc		<=	'0';
--				MemToReg	<=	'0';
--				RegWrite	<=	'0';
--				MemRead		<=	'0';
--				MemWrite	<=	'0';
--				Branch		<=	'0';
--				ALUOp		<=	"00";
--	end case;
end architecture;	
