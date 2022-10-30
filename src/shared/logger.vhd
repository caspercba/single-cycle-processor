library IEEE;
use IEEE.std_logic_1164.all;

package logger is
	
	constant show_info: std_ulogic := 'H';
	constant show_err: std_ulogic := 'H';

	procedure log(data: string); 
	procedure err(data: string);
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
end package body logger;

-- Severity type is std.standard.severity_level
-- possible values are: note, warning, error, failure

-- source: https://insights.sigasi.com/tech/vhdl-assert-and-report/

