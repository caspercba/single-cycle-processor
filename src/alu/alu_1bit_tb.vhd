library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- these libraries will not synthesise
-- they allow to open files etc in test
use std.textio.all;
-- use ieee.std_logic_textio.all;

entity alu_1bit_tb is
  end;

architecture test of alu_1bit_tb is


component alu_1bit
  port(
    a                   : in std_logic;
    b                   : in std_logic;
    c_in                : in std_logic;
    m1                  : in std_logic;
    m2                  : in std_logic;
    m3                  : in std_logic;
    result              : out std_logic;
    c_out               : out std_logic
);

end component;

signal a        : std_logic;
signal b        : std_logic;
signal c_in     : std_logic;
signal m1       : std_logic;
signal m2       : std_logic;
signal m3       : std_logic;
signal result   : std_logic;
signal c_out    : std_logic;

begin

  dev_to_test:  alu_1bit
    port map(a, b, c_in, m1, m2, m3, result, c_out);
  
      
  stimulus: process

    variable WriteBuf           : line;
    variable ErrorCount         : integer := 0;

    begin
      a <= '1';
      b <= '0';
      c_in <= '0';
      m1 <= '1';
      m2 <= '1';
      m3 <= '1';

    wait for 10 ns;

    if (result /= '1') then
      -- write(WriteBuf, string("Error"));
      ErrorCount := ErrorCount + 1;
    end if;

    if (ErrorCount = 0) then
      report "Sucess!";
    else
      report "Errors occurred" severity warning;
    end if;

  end process stimulus;

  end test;
