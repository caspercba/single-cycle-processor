library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;

entity signext is
	port(
	a		: in std_logic_vector(31 downto 0);
	y		: out std_logic_vector(63 downto 0)
);
end signext;

architecture behavioural of signext is
--signal zeros : std_logic_vector(63 downto 0):=(others=>'0');
	signal zeros: std_logic_vector (63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";
	constant LDUR_OP: std_logic_vector := "11111000010";
	alias ldur_operation is a(31 downto 21);
	alias ldur_address	is a(20 downto 12);
begin
	process(a)
	begin
	--if(ldur_operation = LDUR_OP) then
		y(8 downto 0) <= a(20 downto 12);
		y(63 downto 9) <= (others => a(20));
	--else
		--y<= (others => '0');
	--end if;
end process;
	--process(a)
	--begin
	--if(a(31 downto 21)=LDUR_OP) then
	--	report( "is LDUR");
	--	y<= zeros(54 downto 0) & a(20 downto 12);
	--else
	--	y<= zeros(31 downto 0) & a;
	--end if;
--end process;
end behavioural;

-- Notes
-- LDUR: OPCODE[11b] + DT_Addr[9 bits] + op[2 bit] + Rn [5 bits] + Rt [5 bits]
