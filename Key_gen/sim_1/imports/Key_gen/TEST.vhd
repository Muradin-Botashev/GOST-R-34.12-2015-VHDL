LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity e_kuz_tb is

end e_kuz_tb;

ARCHITECTURE behavior OF e_kuz_tb IS
COMPONENT e_kuz
PORT(
	clk : IN std_logic;
	load : IN std_logic;
	d_in : IN std_logic_vector(255 downto 0):= (others => '0');
	f_out_R,f_out_L : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : OUT std_logic
	);
END COMPONENT;

signal clk : std_logic := '0';
signal load : std_logic := '0';
signal d_in : std_logic_vector(255 downto 0) := (others => '0');
signal f_out_R,f_out_L : STD_LOGIC_VECTOR (127 downto 0);
signal f_out_stb : std_logic;
constant clk_period : time := 10 ns;

BEGIN
uut: e_kuz PORT MAP (
    clk => clk,
    load => load,
    d_in => d_in,
    f_out_R => f_out_R,
    f_out_L => f_out_L,
    f_out_stb => f_out_stb
    );
clk_process :process
begin
	clk <= '1';
	wait for clk_period/2;
	clk <= '0';
	wait for clk_period/2;
end process;
stim_proc: process
begin
wait for 101 ns;
wait for 10 ns;
	load <= '1';
	d_in <= x"8899aabbccddeeff0011223344556677fedcba98765432100123456789abcdef";
wait for 10 ns;
        load <= '0';
while (f_out_stb = '0') loop
    load <= '0';
	wait for 10 ns;
	end loop;
wait;
end process;
END;