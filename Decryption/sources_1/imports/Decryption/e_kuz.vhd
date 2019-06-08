library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity e_kuz is
Port (clk: in STD_LOGIC;
	load : in STD_LOGIC;
	key_data : in STD_LOGIC_VECTOR (127 downto 0);
	key_addr : in STD_LOGIC_VECTOR (3 downto 0);
	key_stb : in STD_LOGIC;
	d_in : in STD_LOGIC_VECTOR (127 downto 0);
	f_out : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : out STD_LOGIC );
end e_kuz;

architecture Behavioral of e_kuz is

component xsl_conv
Port ( clk, load : in STD_LOGIC;
	d_in, key : in STD_LOGIC_VECTOR (127 downto 0);
	f_out : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : out STD_LOGIC );
end component;

	type ext_key_type is array (9 downto 0) of std_logic_vector (127 downto 0);
	signal key : ext_key_type;
	signal tmp_key: STD_LOGIC_VECTOR (127 downto 0);
	signal n_key, tmp, tmpR: STD_LOGIC_VECTOR (127 downto 0);
	signal tmpR_stb, xsl_load : STD_LOGIC;
	signal count: STD_LOGIC_VECTOR (3 downto 0);
	
begin
process(clk)
begin
	if(clk'event and clk = '1') then
		if(key_stb = '1') then
			key(CONV_INTEGER(key_addr)) <= key_data;
		end if;
	end if;
end process;

process (clk, load, key, d_in)
begin
	if (clk'event and clk ='1') then
		if (load = '1') then
			tmp_key <= key(0); 
			count <= "0001"; 
			tmp <= d_in; 

		elsif(tmpR_stb = '1' and count < "1001") then
			tmp_key <= key(CONV_INTEGER(count));
			count <= count + 1;
			tmp<=tmpR;
		end if;
	end if;
end process;

process(clk)
begin
	if(clk'event and clk = '1') then
		if(load = '1') then
			xsl_load <= '1'; 
		else
			if(count < "1001") then
				xsl_load <= tmpR_stb;
			else
				xsl_load <= '0';
			end if;
		end if;
	end if;
end process;
conv1: xsl_conv port map (clk, xsl_load, tmp, tmp_key, tmpR, tmpR_stb);
f_out <= tmpR xor key(9);
f_out_stb <= '1' when (count = "1001" and tmpR_stb = '1') else '0';
end Behavioral;