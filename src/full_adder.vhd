library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    port(
        a:      in std_logic;
        b:      in std_logic;
        c_in:   in std_logic;
        sum:    out std_logic;
        c_out:  out std_logic
    );

end full_adder;

architecture a of full_adder is
    begin
        sum <= a xor b xor c_in;
        c_out <= (a and b) or (a and c_in) or (b and c_in);
    end; 
