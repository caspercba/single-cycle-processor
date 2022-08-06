library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    generic(data_size : integer := 64);
    port(
        a:          in std_logic_vector(data_size - 1 downto 0);
        b:          in std_logic_vector(data_size - 1 downto 0);
        overflow:   out std_logic;
        result:     out std_logic_vector(data_size - 1 downto 0)
    );
end adder;

architecture structural of adder is
    component full_adder is
        port(
            a:      in std_logic;
            b:      in std_logic;
            c_in:   in std_logic;
            sum:    out std_logic;
            c_out:  out std_logic
        );
    end component;

    signal s_a, s_b, c_i:     std_logic_vector(data_size - 1 downto 0);    

    begin
        c_i(0) <= '0';
        GEN: for i in 0 to data_size - 1 generate
            adder_instance: full_adder
            port map(
                a => s_a(i),
                b => s_b(i),
                c_in => c_i(i),
                sum => result(i),
                c_out => c_i(i+1)
            );
        end generate GEN;

        s_a <= a;
        s_b <= b;
end architecture structural;