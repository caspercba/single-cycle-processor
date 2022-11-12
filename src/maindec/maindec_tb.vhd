library ieee;
use ieee.std_logic_1164.all;

library work;
use work.operations.all;
use work.logger.log;

entity maindec_tb is
end maindec_tb;

architecture test of maindec_tb is

	subtype operation is std_logic_vector(10 downto 0);


	component maindec is
		port(
			Op	: in operation;
			RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out std_logic;
			ALUOp	: out std_logic_vector(1 downto 0)
		);
	end component maindec;

			signal Op	: operation;
			signal RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: std_logic;
			signal ALUOp	: std_logic_vector(1 downto 0);
	
	type test_vector is record
		Op	:	operation;
		RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: std_logic;
		ALUOp	:	std_logic_vector(1 downto 0);
	end record test_vector;

	type test_data is array (natural range <>) of test_vector;

	constant tests: test_data := (
	(OP_ADD, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_SUB, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_AND, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_ORR, '0', '0', '0', '1', '0', '0', '0', "10"),
	(OP_LDUR, '0', '1', '1', '1', '1', '0', '0', "00"),
	(OP_STUR, '1', '1', '0', '0', '0', '1', '0', "00"),
	(OP_CBZ, '1', '0', '0', '1', '0', '0', '1', "01"),
	("11111111111", '0', '0', '0', '0', '0', '0', '0', "00")
);


begin
	UUT: entity work.maindec
	port map(	
		Op	=>Op,
		RegToLoc=>RegToLoc,
		ALUSrc	=> ALUSrc,
		MemtoReg=> MemtoReg,
		RegWrite=> RegWrite,
		MemRead	=> MemRead,
		MemWrite=> MemWrite,
		Branch	=> Branch
	);
	
	stimulus: process
	begin
		for i in tests'range loop
			log("maindec testcase #" & to_string(i) & " of " & to_string(tests'length));
			Op<=tests(i).Op;
			assert RegToLoc=tests(i).RegToLoc report "Expected: " & to_string(tests(i).RegToLoc) & " Got: " & to_string(RegToLoc) severity error;
			assert ALUSrc=tests(i).ALUSrc report "Expected: " & to_string(tests(i).ALUSrc) & " Got: " & to_string(ALUSrc) severity error;
			assert MemtoReg=tests(i).MemtoReg report "Expected: " & to_string(tests(i).MemtoReg) & " Got: " & to_string(MemtoReg) severity error;
			assert RegWrite=tests(i).RegWrite report "Expected: " & to_string(tests(i).MemtoReg) & " Got: " & to_string(RegWrite) severity error;
			assert MemRead=tests(i).MemRead report "Expected: " & to_string(tests(i).MemRead) & " Got: " & to_string(MemRead) severity error;
			assert MemWrite=tests(i).MemWrite report "Expected: " & to_string(tests(i).MemWrite) & " Got: " & to_string(MemWrite) severity error;
			assert Branch=tests(i).Branch report "Expected: " & to_string(tests(i).Branch) & " Got: " & to_string(Branch) severity error;
		end loop;
	end process stimulus;
end test;

