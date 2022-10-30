library ieee;
use ieee.std_logic_1164.all;

entity imem is
	generic(datawidth: integer :=32);
	port(
	addr	: in std_logic_vector(5 downto 0);
	q	: out std_logic_vector(datawidth - 1 downto 0)
);
end imem;

architecture behavioural of imem is
	-- singals or constants here
begin
	process(addr)
	begin

		case addr is
			when "000000" => q<=x"f8000000";
			when "000001" => q<=x"f8008001";
			when "000010" => q<=x"f8010002";
			when "000011" => q<=x"f8018003";
			when "000100" => q<=x"f8020004";
			when "000101" => q<=x"f8028005";
			when "000110" => q<=x"f8030006";
			when "000111" => q<=x"f8400007";
			when "001000" => q<=x"f8408008";
			when "001001" => q<=x"f8410009";
			when "001010" => q<=x"f841800a";
			when "001011" => q<=x"f842000b";
			when "001100" => q<=x"f842800c";
			when "001101" => q<=x"f843000d";
			when "001110" => q<=x"cb0e01ce";
			when "001111" => q<=x"b400004e";
			when "010000" => q<=x"cb01000f";
			when "010001" => q<=x"8b01000f";
			when "010010" => q<=x"f803800f";
			when others => q<=x"00000000";
		end case;
	end process;
end architecture behavioural;
