library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_1bit is
  port(
    a 			: in std_logic;		-- param 1
    b			: in std_logic;		-- param 2
    c_in                : in std_logic;
    m1                  : in std_logic;
    m2                  : in std_logic;
    m3                  : in std_logic;
    result	        : out std_logic;	-- result 
    c_out	        : out std_logic
);					
  
end alu_1bit;

architecture datapath_z80 of alu_1bit is
  signal c_m3           : std_logic;
  signal c_out_s        :std_logic;
  
  begin
    c_m3 <= not (c_in and m3);
    c_out_s <= not ((((((not a) and (not b)) or c_m3) and ((not a) or (not b))) and m1));
    result <= not(((c_out_s and m2) or (((not a) and (not b)) and c_m3)) and ((c_m3 and m1) or ((not a) or (not b))));
    c_out <= c_out_s;
end datapath_z80;

architecture behavioural of alu_1bit is
begin
    process(a, b, c_in, m1, m2, m3)
    begin
    if (m1='1' and m2='1' and m3='1') then
      result <= (a xor b) xor c_in;
      c_out <= (a and b) or ( a and c_in) or (b and c_in);
    else
      result <= '0';
      c_out <= '0';
    end if;
  end process;
end behavioural;
    
