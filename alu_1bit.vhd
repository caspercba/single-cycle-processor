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

architecture dataflow_z80 of alu_1bit is
  signal c_m3 : std_logic;
  begin
    c_m3 <= not (c and m3);
    c_out <= not ((((not a) and (not b)) or c_m3) and ((not a) or (not b)) and m1);
    result <= not ((c_out and m2) or (((not a) and (not b)) and c_m3) and ((c_m3 and m1) or ((not a) or (not b))));
  end architecture dataflow_z80;

    
