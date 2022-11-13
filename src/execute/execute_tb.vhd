library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;
use ieee.numeric_std.all;

library work;
use work.logger.all;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity execute_tb is
end execute_tb;

architecture test of execute_tb is
	
	signal AluSrc			:	std_logic := '0';
	signal AluControl		:	std_logic_vector(3 downto 0) := (others => '0');
	signal PC_E, signImm_E		:	data_bus := (others => '0');
	signal readData1_E		:	data_bus := (others => '0');
	signal readData2_E		:	data_bus := (others => '0');
	signal PCBranch_E, aluResult_E	:	data_bus := (others => '0');
	signal writeData_E		:	data_bus := (others => '0');
	signal zero_E			:	std_logic := '0';
	
	constant DEC_1300	:	data_bus := int_to_vec(1300, data_bus'length);
	constant DEC_1200	:	data_bus := int_to_vec(1200, data_bus'length);
	constant DEC_500	:	data_bus := int_to_vec(500, data_bus'length);
	constant DEC_400	:	data_bus := int_to_vec(400, data_bus'length);
	constant DEC_300	:	data_bus := int_to_vec(300, data_bus'length);
	constant DEC_200	:	data_bus := int_to_vec(200, data_bus'length);
	constant DEC_100	:	data_bus := int_to_vec(100, data_bus'length);

	type test_vector is record
		AluSrc			:	std_logic;
		AluControl		:	std_logic_vector(3 downto 0);
		PC_E, signImm_E		:	data_bus;
		readData1_E		:	data_bus;
		readData2_E		:	data_bus;
		PCBranch_E, aluResult_E	:	data_bus;
		writeData_E		:	data_bus;
		zero_E			:	std_logic;
	end record test_vector;

	type test_data is array (natural range <>) of test_vector;

	constant tests: test_data := (
-- AluSrc, AluControl, PC_E   ,signImm , readD1 , readD2 , PCBranc, aluRes , writeD, zero
	('0', ADD_HEX, DEC_100, DEC_100, DEC_100, DEC_200, DEC_500, DEC_300, DEC_200, '0'),
	('0', AND_HEX, DEC_100, DEC_100, DEC_100, DEC_100, DEC_500, DEC_100, DEC_100, '0'),
	('1', ADD_HEX, DEC_100, DEC_300, DEC_100, DEC_200, DEC_1300, DEC_400, DEC_200, '0'),
	('1', ADD_HEX, DEC_100, DEC_100, DEC_100, DEC_200, DEC_500, DEC_200, DEC_200, '0')
	);

	
begin
	dut : entity work.execute
	port map(AluSrc => AluSrc, AluControl => AluControl,
		PC_E => PC_E, signImm_E => signImm_E,
		readData1_E => readData1_E, readData2_E => readData2_E,
		PCBranch_E => PCBranch_E, aluResult_E => aluResult_E,
		writeData_E => writeData_E, zero_E => zero_E);

	stimulus : process
	begin
		wait for 5 ns;
		for i in tests'range loop
			AluSrc		<= tests(i).AluSrc;
			AluControl	<= tests(i).AluControl;
			PC_E		<= tests(i).PC_E;
			signImm_E	<= tests(i).signImm_E;
			readData1_E	<= tests(i).readData1_E;
			readData2_E	<= tests(i).readData2_E;
			wait for 1 ns;
			checkEqual(tests(i).PCBranch_E, PCBranch_E, "Test[" & to_string(i) & "] PCBranch_E");
			checkEqual(tests(i).aluResult_E, aluResult_E, "Test[" & to_string(i) & "] aluResut_E");
			checkEqual(tests(i).writeData_E, writeData_E, "Test[" & to_string(i) & "] writeData_E");
			checkEqual(tests(i).zero_E, zero_E, "Test[" & to_string(i) & "] zero_E");
		end loop;		
		stop;
			
	end process;
end architecture;
			
					
	
