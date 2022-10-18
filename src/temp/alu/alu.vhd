library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
	generic(data_width : integer := 64);

	port(
		a 			: in std_logic_vector(data_width - 1 downto 0);		-- param 1
		b			: in std_logic_vector(data_width - 1 downto 0);		-- param 2
		ALUControl	        : in std_logic_vector(3 downto 0);					-- operation 4bits
		result		        : out std_logic_vector(data_width - 1 downto 0);	-- result 
		zero		        : out std_logic                           -- 1 if result is 0
    );								

end alu;

architecture behaviour of alu is
begin
  commands: process (ALUControl)
  begin
    
            case ALUControl is
                when "0000" =>
                    result <= a and b;
                when "0001" =>
                    result <= a or b;
                when "0010" =>
                    -- ADD a+b
                    result <= a or b;
                when "0110" =>
                    -- SUB a-b
                    result <= a or b;
                when "0111" =>
                    result <= b;	-- pass input b
                when "1100" =>
                    result <= not (a or b);	-- a NOR b
                when others =>
                    result <= (others => 'X');  -- never forget this, avoids memory
            end case;
        end process commands;
end behaviour;




