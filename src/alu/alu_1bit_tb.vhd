library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- these libraries will not synthesise
-- they allow to open files etc in test
use std.textio.all;
-- use ieee.std_logic_textio.all;

entity alu_1bit_tb is
end alu_1bit_tb;

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
  
  signal a,b,c_in,m1,m2,m3      : std_logic;
  signal result,c_out : std_logic;

  type test_vector is record
    a,b,c_in,m1,m2,m3   : std_logic;
    result,c_out        : std_logic; 
  end record;

  type test_vector_array is array (natural range <>) of test_vector;

-- ADD = m1=1, m2=1, m3=1
constant test_vector_add : test_vector_array := (
  ('0', '0', '0', '1', '1', '1', '0', '0'),
  ('0', '0', '1', '1', '1', '1', '1', '0'),
  ('0', '1', '0', '1', '1', '1', '1', '0'),
  ('0', '1', '1', '1', '1', '1', '0', '1'),
  ('1', '0', '0', '1', '1', '1', '1', '0'),
  ('1', '0', '1', '1', '1', '1', '0', '1'),
  ('1', '1', '0', '1', '1', '1', '0', '1'),
  ('1', '1', '1', '1', '1', '1', '1', '1')
  );

begin
  
  dev_to_test: entity work.alu_1bit(datapath_z80)
    port map(a => a, b => b, c_in => c_in, m1 => m1, m2 => m2, m3 => m3, result => result, c_out => c_out);
  
  
      
  stimulus: process

    variable WriteBuf           : line;
    variable ErrorCount         : integer := 0;

    begin
      for i in test_vector_add'range loop
        a <= test_vector_add(i).a;
        b <= test_vector_add(i).b;
        c_in <= test_vector_add(i).c_in;
        m1 <= test_vector_add(i).m1;
        m2 <= test_vector_add(i).m2;
        m3 <= test_vector_add(i).m3;

        wait for 1000 ns;

        assert((result = test_vector_add(i).result) and (c_out = test_vector_add(i).c_out))

        report "test_vector " & integer'image(i) & " failed " &
          " for input a = " & std_logic'image(a) &
          " and b = " & std_logic'image(b) &
          " and c_in = " & std_logic'image(c_in) &
          " and m1 = " & std_logic'image(m1) &
          " and m2 = " & std_logic'image(m2) &
          " and m3 = " & std_logic'image(m3) &
          " result = " & std_logic'image(result) &
          " expected = " & std_logic'image(test_vector_add(i).result) &
          " c_out = " & std_logic'image(c_out) &
          " expected = " & std_logic'image(test_vector_add(i).c_out)
        severity error;
    end loop;
    wait;
  end process stimulus;
end test;
