library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use std.textio.all;
library work;
use work.operations.ALL;




entity signext is
	port(
	a		: in std_logic_vector(31 downto 0);
	y		: out std_logic_vector(63 downto 0)
);
end signext;

architecture behavioural of signext is
	alias D_address_sign is a(20);
	alias CB_address_sign is a(23);
begin
	process(a)
	begin
	if(a(D_RANGE_OP) = OP_LDUR or a(D_RANGE_OP) = OP_STUR) then
		y(D_ADDR_SIZE-1 downto 0) <= a(D_RANGE_ADD);
		y(63 downto D_ADDR_SIZE) <= (others => D_address_sign);
	elsif(a(CB_RANGE_OP) = OP_CBZ) then
		y(CB_ADDR_SIZE-1 downto 0) <= a(CB_RANGE_ADD);
		y(63 downto CB_ADDR_SIZE) <= (others => CB_address_sign);
	else
		y<= (others => '0');
	end if;
end process;
end behavioural;

