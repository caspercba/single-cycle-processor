library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logger.log;
use work.operations.all;

entity memory is port(
	Branch_M	:	in std_logic := '0';
	zero_M		:	in std_logic := '0';
	PCSrc_M		:	out std_logic := '0'
);
end entity memory;

architecture behavioural of memory is
begin
	PCSrc_M <= Branch_M and zero_M;
end architecture;
