library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signext is
	port(
	a		: in std_logic_vector(31 downto 0);
	y		: out std_logic_vector(63 downto 0)
);
end signext;

architecture behavioural of signext is
signal zeros : std_logic_vector(63 downto 0):=(others=>'0');
constant LDUR_OP: std_logic_vector := "11111000010";
begin
	process(a)
	begin
	if(a(31 downto 21)=LDUR_OP) then
		y<= zeros(54 downto 0) & a(20 downto 12);
	else
		y<= zeros(31 downto 0) & a;
	end if;
end process;
end behavioural;

-- Notes
-- LDUR: OPCODE[11b] + DT_Addr[9 bits] + op[2 bit] + Rn [5 bits] + Rt [5 bits]
