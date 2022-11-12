library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--use std.textio.all;
library work;
use work.alu_helper.ALL;
use work.logger.log;
use work.operations.all;




entity alu is
	port(
	a,b		: in data_bus; 
	ALUControl	: in std_logic_vector(3 downto 0);
	result		: out data_bus; 
	zero		: out std_logic
);
end alu;


architecture behavioural of alu is
-- define here signals if needed
	constant zeroes	: std_logic_vector(result'range) := (others => '0');
begin
	process(a,b,ALUControl)
		variable operation	: 	alu_op:=A_NONE;
		variable result_buf	:	data_bus;	
	begin
		zero <= '0';
		operation := parse_op(ALUControl);
		case operation is
			when A_AND 	=> result_buf := (a and b);
			when A_OR 	=> result_buf := a or b;
			when A_ADD 	=> result_buf:=std_logic_vector(signed(a) + signed(b));
			when A_SUB	=> result_buf:= std_logic_vector(signed(a) - signed(b));
			when A_PASS	=> result_buf:= b;
			when A_NOR	=> result_buf:=a nor b;
			when A_NONE	=> result_buf:=(others=>'0');
		end case;
		
		if result_buf = zeroes then
			zero<='1';
		end if;
		if operation /= A_NONE then 
			log_op(operation, a, b);
		end if;
		result <= result_buf;
end process;
end behavioural;

