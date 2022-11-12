library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package operations is

	-- General Notice about constants. In order to use them in other packages,
	-- we need them to be constained. In the case of std_logic_vector, we have to
	-- expclicitly write the range. 
	-- for more info see this issue from Aug 30th 2022:
	-- https://github.com/ghdl/ghdl/issues/2184

	constant D_OP_SIZE: integer := 11;
	constant D_ADDR_SIZE: integer := 9;
	
	constant CB_OP_SIZE: integer := 8;
	constant CB_ADDR_SIZE: integer := 19;

	constant R_OP_SIZE: integer := 11;

	-- D type operations
	constant OP_LDUR: std_logic_vector(D_OP_SIZE-1 downto 0) := "11111000010";
	constant OP_STUR: std_logic_vector(D_OP_SIZE-1 downto 0) := "11111000000";

	-- CB type operations
	constant OP_CBZ	: std_logic_vector(CB_OP_SIZE-1 downto 0) := "10110100";
	constant OP_CBZ_COMPAT : std_logic_vector(R_OP_SIZE-1 downto 0) := OP_CBZ & "XXX";

	-- R operations
	constant OP_ADD : std_logic_vector(R_OP_SIZE-1 downto 0) := "10001011000";
	constant OP_SUB : std_logic_vector(R_OP_SIZE-1 downto 0) := "11001011000";
	constant OP_AND : std_logic_vector(R_OP_SIZE-1 downto 0) := "10001010000";
	constant OP_ORR : std_logic_vector(R_OP_SIZE-1 downto 0) := "10101010000";

	constant INSTR_SIZE: integer := 32;


	subtype D_RANGE_OP 	is	integer range INSTR_SIZE-1 downto INSTR_SIZE-D_OP_SIZE;
	subtype D_RANGE_ADD	is	integer range INSTR_SIZE-D_OP_SIZE-1 downto INSTR_SIZE-D_OP_SIZE-D_ADDR_SIZE;
	
	subtype CB_RANGE_OP 	is	integer range INSTR_SIZE-1 downto INSTR_SIZE-CB_OP_SIZE;
	subtype CB_RANGE_ADD	is	integer range INSTR_SIZE-CB_OP_SIZE-1 downto INSTR_SIZE-CB_OP_SIZE-CB_ADDR_SIZE;

	subtype R_RANGE_OP	is	integer range INSTR_SIZE-1 downto INSTR_SIZE-R_OP_SIZE;

	function build_D_instruction (
		op	:std_logic_vector(D_OP_SIZE - 1 downto 0);
		addr	:std_logic_vector(D_ADDR_SIZE - 1 downto 0)) return std_logic_vector;
	
	function build_CB_instruction (
		op	:std_logic_vector(CB_OP_SIZE - 1 downto 0);
		addr	:std_logic_vector(CB_ADDR_SIZE - 1 downto 0)) return std_logic_vector;
	
	function build_R_instruction (
		op	:std_logic_vector(R_OP_SIZE - 1 downto 0)) return std_logic_vector;

end operations;

package body operations is
	function build_D_instruction (
		op	:std_logic_vector(D_OP_SIZE-1 downto 0);
		addr	:std_logic_vector(D_ADDR_SIZE-1 downto 0)) return std_logic_vector is
	begin
		return op & addr & "000000000000";
	end function;
	
	function build_CB_instruction (
		op	:std_logic_vector(CB_OP_SIZE-1 downto 0);
		addr	:std_logic_vector(CB_ADDR_SIZE-1 downto 0)) return std_logic_vector is
	begin
		return op & addr & "11111";
	end function;

	function build_R_instruction (
		op	:std_logic_vector(R_OP_SIZE-1 downto 0)) return std_logic_vector is
	begin
		return op & "111111111111111111111";
	end function;
end package body operations;
