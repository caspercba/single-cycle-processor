library ieee;
use ieee.std_logic_1164.all;

library work;
use work.operations.all;
use work.logger.log;
use std.env.stop;

entity maindec_tb is
end maindec_tb;

architecture test of maindec_tb is

	subtype op_type is std_logic_vector(R_OP_SIZE-1 downto 0);
	subtype alu_op_type is std_logic_vector(1 downto 0);

	component maindec is
		port(
			op	: in op_type;
			RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out std_logic;
			ALUOp	: out alu_op_type 
		);
	end component maindec;

	signal op	: op_type; 
	signal RegToLoc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch : std_logic := '0';
	signal ALUOp	: alu_op_type; 
	
	type test_vector is record
		op	:	op_type;
		RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: std_logic;
		ALUOp	:	alu_op_type;
	end record test_vector;

	type test_data is array (natural range <>) of test_vector;

	constant tests: test_data := (
	(OP_ADD, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_SUB, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_AND, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_ORR, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_LDUR, '0', '1', '1', '1', '1', '0', '0', "00"),
	(OP_STUR, '1', '1', '0', '0', '0', '1', '0', "00"),
	(OP_CBZ_COMPAT, '1', '0', '0', '0', '0', '0', '1', "01"),
	("11111111111", '0', '0', '0', '0', '0', '0', '0', "00")
);


begin
	UUT: entity work.maindec
	port map(	
		op	=>op,
		RegToLoc=>RegToLoc,
		ALUSrc	=> ALUSrc,
		MemtoReg=> MemtoReg,
		RegWrite=> RegWrite,
		MemRead	=> MemRead,
		MemWrite=> MemWrite,
		Branch	=> Branch,
		ALUOp	=> ALUOp
	);
	
	stimulus: process
	begin
		for i in tests'range loop
			log("maindec testcase #" & to_string(i+1) & " of " & to_string(tests'length));
			op<=tests(i).op;
			wait for 1 ps;
			assert RegToLoc=tests(i).RegToLoc report "RegToLoc Expected: " & to_string(tests(i).RegToLoc) & " Got: " & to_string(RegToLoc) severity error;
			assert ALUSrc=tests(i).ALUSrc report "ALUSrc Expected: " & to_string(tests(i).ALUSrc) & " Got: " & to_string(ALUSrc) severity error;
			assert MemtoReg=tests(i).MemtoReg report "MemtoReg Expected: " & to_string(tests(i).MemtoReg) & " Got: " & to_string(MemtoReg) severity error;
			assert RegWrite=tests(i).RegWrite report "RegWrite Expected: " & to_string(tests(i).MemtoReg) & " Got: " & to_string(RegWrite) severity error;
			assert MemRead=tests(i).MemRead report "MemRead Expected: " & to_string(tests(i).MemRead) & " Got: " & to_string(MemRead) severity error;
			assert MemWrite=tests(i).MemWrite report "MemWrite Expected: " & to_string(tests(i).MemWrite) & " Got: " & to_string(MemWrite) severity error;
			assert Branch=tests(i).Branch report "Branch Expected: " & to_string(tests(i).Branch) & " Got: " & to_string(Branch) severity error;
			assert ALUOp=tests(i).ALUOp report "ALUOp Expected: " & to_hex_string(tests(i).ALUOp) & " Got: " & to_hex_string(ALUOp) severity error;
		end loop;
		stop;
	end process stimulus;
end test;

