library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- these libraries will not synthesise
-- they allow to open files etc in test
use std.textio.all;
use ieee.std_logic_textio.all;

entity [test_bench_entity] is
  end;

architecture test of [test_bench_entity] is


component [name_of_entity_tested]
-- Instantiate component of the VHDL enity
-- you are testing
end component;

-- Create signals used in testbench

begin
  -- Sometimes this is called UUT Unit Under Test
  dev_to_test:  [name_of_entity_tested port map(

    -- Define inputs and outputs here

    expected_proc : process(inputs)
      begin
        -- PLace code here that gives the results you want
        -- For example for every input you will specify what the
        -- output should be

      end process expected_proc;

      stimulus : process
        begin
          -- Place your code that goes throufh and applies
          -- a stimulus to the dev_to_test also 
