library ieee;
use ieee.std_logic_1164.all;

library work;
use work.operations.all;

architecture test of maindec_tb is

	subtype op is std_logic_vector(10 downto 0);


	component maindec is
		port(
			Op	: in op;
			RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out std_logic;
			ALUOp	: out std_logic_vector(1 downto 0)
		);
	end component maindec;

			signal Op	: op;
			signal RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: std_logic;
			signal ALUOp	: std_logic_vector(1 downto 0)
	
	type test_vector is record
		Op	:	op;
		RegToLoc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: std_logic;
		ALUOp	:	std_logic_vector(1 downto 0);
	end record test_vector;

	type test_data is array (natural range <>) of test_vector;

	constant tests: test_data := (
	(OP_ADD, 0, 0, 0, 1, 0, 0, 0, "10"),
	(OP_SUB, 0, 0, 0, 1, 0, 0, 0, "10"),
	(OP_AND, 0, 0, 0, 1, 0, 0, 0, "10"),
	(OP_ORR, 0, 0, 0, 1, 0, 0, 0, "10"),
	(OP_LDUR, 0, 1, 1, 1, 1, 0, 0, "00"),
	(OP_STUR, 1, 1, 0, 0, 0, 1, 0, "00"),
	(OP_CBZ, 1, 0, 0, 1, 0, 0, 1, "01"),
	("11111111111", 0, 0, 0, 0, 0, 0, 0, "00")
);


begin
	UUT: entity work.maindec
	port map(	
		Op	=>Op;
		RegToLoc=>RegToLoc;
		ALUSrc	=> ALUScr;
		MemtoReg=> MemtoReg;
		RegWrite=> RegWrite;
		MemRead	=> MemRead;
		MemWrite=> MemWrite;
		Branch	=> Branch
	);
	
	stimulus: process
	begin
		for i in tests'range loop
			log("maindec testcase #" & to_string(i) & " of " & to_string(tests'length)
			Op<=tests(i).Op;
			RegToLoc<=tests(i).RegToLoc;
			ALUSrc<=tests(i).ALUSrc;
			MemtoReg<=tests(i).MemtoReg;
			RegWrite<=tests(i).RegWrite;
			MemRead<=tests(i).MemRead;
			MemWrite<=tests(i).MemWrite;
			Branch<=tests(i).Branch;

