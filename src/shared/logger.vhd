library IEEE;
use IEEE.std_logic_1164.all;

package logger is
	
	constant show_info: std_ulogic := 'H';
	constant show_err: std_ulogic := 'H';

	procedure log(data: string); 
	procedure err(data: string);
	procedure checkEqual(expected: std_logic_vector; actual: std_logic_vector; desc: string);
	procedure checkZeroes(param: std_logic_vector; desc: string);
end logger;

package body logger is
	procedure log(data: string) is
	begin
		if(show_info) then
			report data 
			severity note;
		end if;
	end procedure;

	procedure err(data: string) is
	begin
		if(show_err) then
			report data
			severity error;
		end if;
	end err;
	
	procedure checkEqual(expected: std_logic_vector; actual: std_logic_vector; desc: string) is
		variable condition: boolean := false;
	begin
		condition := (expected=actual);
		if condition=true then
			log("CHECK EQUAL: " & desc);
		else
			assert expected=actual
			report desc & " ==> FAILED" & "(Expected: " & to_hex_string(expected) 
			& " || Got: " & to_hex_string(actual) & ")" severity error;
		end if;
	end checkEqual;

	procedure checkZeroes(param: std_logic_vector; desc: string) is
		variable condition : boolean := false;	
	begin
		condition := or param = '0';
		if condition=true then
			log("Checking if vector is all zeroes: " & to_hex_string(param));
		else
			assert condition
			report desc & " ==> FAILED " & "(Expected all zero || Got: " & to_hex_string(param)
			severity error;
		end if;
	end checkZeroes;

end package body logger;

-- Severity type is std.standard.severity_level
-- possible values are: note, warning, error, failure

-- source: https://insights.sigasi.com/tech/vhdl-assert-and-report/

