library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

package ss_math is
	function int_to_vec(param: integer; size: integer) return std_logic_vector;
	function vec_to_int(param: std_logic_vector) return signed;
end package ss_math;

package body ss_math is
	
	function int_to_vec(param: integer; size: integer) return std_logic_vector is
	begin
		return std_logic_vector(to_signed(param, size));
	end function int_to_vec;

	function vec_to_int(param: std_logic_vector) return signed is
	begin
		return signed(param);
	end function vec_to_int;
	
end package body ss_math;
