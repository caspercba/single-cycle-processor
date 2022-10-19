library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package alu_helper is

	constant CTRL_AND: std_logic_vector := "0000";
	constant CTRL_OR:  std_logic_vector := "0001";
	constant CTRL_ADD: std_logic_vector := "0010";
	constant CTRL_SUB: std_logic_vector := "0110";
	constant CTRL_PASS:std_logic_vector := "0111";
	constant CTRL_NOR: std_logic_vector := "1100";


end package alu_helper;
