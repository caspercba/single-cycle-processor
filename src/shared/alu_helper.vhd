library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.logger.log;

package alu_helper is

	constant AND_HEX	:std_logic_vector(3 downto 0)	:= "0000";
	constant OR_HEX		:std_logic_vector(3 downto 0)	:= "0001";
	constant ADD_HEX	:std_logic_vector(3 downto 0)	:= "0010";
	constant SUB_HEX	:std_logic_vector(3 downto 0)	:= "0110";
	constant PASS_HEX	:std_logic_vector(3 downto 0)	:= "0111";
	constant NOR_HEX	:std_logic_vector(3 downto 0)	:= "1100";
	constant NONE_HEX	:std_logic_vector(3 downto 0)	:= "1111";

	type alu_op is (A_AND, A_OR, A_ADD, A_SUB, A_PASS, A_NOR, A_NONE);

	function parse_op(param: std_logic_vector(3 downto 0)) return alu_op; 

	function op_to_vector(op: alu_op) return std_logic_vector;

	procedure log_op(operation: alu_op; param1: std_logic_vector; param2: std_logic_vector); 

end package alu_helper;

package body alu_helper is

	function op_to_vector(op: alu_op) return std_logic_vector is
	begin
		case op is
			when A_AND 	=> return AND_HEX;
			when A_OR	=> return OR_HEX;
			when A_ADD	=> return ADD_HEX;
			when A_SUB	=> return SUB_HEX;
			when A_PASS	=> return PASS_HEX;
			when A_NOR	=> return NOR_HEX;
			when A_NONE	=> return NONE_HEX;
		end case;
	end function op_to_vector;

	function parse_op(param: std_logic_vector(3 downto 0)) return alu_op is
	begin
		case param is
			when AND_HEX => return A_AND;
			when OR_HEX => return A_OR;
			when ADD_HEX => return A_ADD;
			when SUB_HEX => return A_SUB;
			when PASS_HEX => return A_PASS;
			when NOR_HEX => return A_NOR;
			when others => return A_NONE;
		end case;
	end function parse_op;

	function print_op(operation: alu_op) return string is
	begin
		case operation is
			when A_AND => 	return "AND";
			when A_OR =>	return "OR";
			when A_ADD =>	return "ADD";	
			when A_SUB =>	return "SUB";	
			when A_PASS =>	return "PASS";	
			when A_NOR =>	return "NOR";	
			when A_NONE =>	return "NONE";	
		end case;
	end function print_op;

	procedure log_op(operation: alu_op; param1: std_logic_vector; param2: std_logic_vector) is
	begin
		log("ALU OP: " & print_op(operation) & " param1: " & to_hex_string(param1) & "h param2: " & to_hex_string(param2) & "h"); 
	end procedure log_op;
end package body alu_helper;
