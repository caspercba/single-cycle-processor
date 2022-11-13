library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.ss_math.all;
use work.operations.all;
use work.alu_helper.all;

entity execute is port(
			AluSrc						:	in std_logic := '0';
			AluControl					:	in std_logic_vector(3 downto 0) := (others => '0');
			PC_E, signImm_E, readData1_E, readData2_E	:	in data_bus := (others => '0');
			PCBranch_E, aluResult_E, writeData_E		:	out data_bus := (others => '0');
			zero_E						:	out std_logic := '0'
		);
end entity execute;

architecture behavioural of execute is
	signal MUX_to_ALU_b		:	data_bus := (others => '0');
	signal MUX_in1_to_shift_left	:	data_bus := (others => '0');
	signal shift_left_to_Add	:	data_bus := (others => '0');
	signal readData2_E_bus		:	data_bus := (others => '0');
begin
	MUX : entity work.mux port map(
		d_in0	=>	readData2_E_bus,
		d_in1	=>	MUX_in1_to_shift_left,
		d_out	=>	MUX_to_ALU_b,
		selector=>	AluSrc	
	);	
	Add : entity work.alu port map(
		a	=>	PC_E,
		b	=>	shift_left_to_Add,
		ALUControl=>	ADD_HEX,	
		result	=>	PCBranch_E	
	);
			
	ALU : entity work.alu port map(
		a		=>	read_Data1_E,
		b		=>	MUX_to_ALU_b,
		ALUControl	=>	AluControl,
		result		=>	aluResult_E
	);	

	readData2_E_bus <= readData2_E;
	writeData_E	<= readData2_E_bus;
	shift_left_to_Add <= MUX_in1_to_shift_left sll 2;		
	MUX_in1_to_shift_left <= signImm_E;

end architecture;
