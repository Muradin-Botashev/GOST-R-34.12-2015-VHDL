LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity e_kuz_tb is

end e_kuz_tb;

ARCHITECTURE behavior OF e_kuz_tb IS
COMPONENT e_kuz
PORT(
	clk : IN std_logic;
	load : IN std_logic;
	key_data : IN std_logic_vector(127 downto 0);
	key_addr : IN std_logic_vector(3 downto 0);
	key_stb : IN std_logic;
	d_in : IN std_logic_vector(127 downto 0);
	f_out : OUT std_logic_vector(127 downto 0);
	f_out_stb : OUT std_logic
	);
END COMPONENT;

signal clk : std_logic := '0';
signal load : std_logic := '0';
signal key_data : std_logic_vector(127 downto 0) := (others => '0');
signal key_addr : std_logic_vector(3 downto 0) := (others => '0');
signal key_stb : std_logic := '0';
signal d_in : std_logic_vector(127 downto 0) := (others => '0');
signal f_out : std_logic_vector(127 downto 0);
signal f_out_stb : std_logic;

constant clk_period : time := 10 ns;
BEGIN
uut: e_kuz PORT MAP (
	clk => clk,
	load => load,
	key_data => key_data,
	key_addr => key_addr,
	key_stb => key_stb,
	d_in => d_in,
	f_out => f_out,
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
	key_stb <= '1';
wait for 10 ns;
	key_addr <= "0000";
	key_data <= x"8899aabbccddeeff0011223344556677";
wait for 10 ns;
	key_addr <= "0001";
	key_data <= x"fedcba98765432100123456789abcdef";
wait for 10 ns;
	key_addr <= "0010";
	key_data <= x"db31485315694343228d6aef8cc78c44";
wait for 10 ns;
	key_addr <= "0011";
	key_data <= x"3d4553d8e9cfec6815ebadc40a9ffd04";
wait for 10 ns;
	key_addr <= "0100";
	key_data <= x"57646468c44a5e28d3e59246f429f1ac";
wait for 10 ns;
	key_addr <= "0101";
	key_data <= x"bd079435165c6432b532e82834da581b";
wait for 10 ns;
	key_addr <= "0110";
	key_data <= x"51e640757e8745de705727265a0098b1";
wait for 10 ns;
	key_addr <= "0111";
	key_data<= x"5a7925017b9fdd3ed72a91a22286f984";
wait for 10 ns;
	key_addr <= "1000";
	key_data <= x"bb44e25378c73123a5f32f73cdb6e517";
wait for 10 ns;
	key_addr <= "1001";
	key_data <= x"72e9dd7416bcf45b755dbaa88e4a4043";
wait for 10 ns;
	key_stb <= '0';
	load <= '1';
	d_in <= x"1122334455667700ffeeddccbbaa9988";
wait for 10 ns;
	load <= '0';
while (f_out_stb = '0') loop
	load <= '0';
	wait for 10 ns;
end loop;
wait;
end process;
END;