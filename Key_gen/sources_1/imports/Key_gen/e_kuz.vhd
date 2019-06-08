library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity e_kuz is
Port (clk: in STD_LOGIC;
	load : in STD_LOGIC;
	d_in : in STD_LOGIC_VECTOR (255 downto 0);
	f_out_R,f_out_L : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : out STD_LOGIC );
end e_kuz;

architecture Behavioral of e_kuz is
component xsl_conv
Port ( clk, load : in STD_LOGIC;
	d_in, C_cosnt : in STD_LOGIC_VECTOR (127 downto 0);
	f_out : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : out STD_LOGIC );
	
end component;
	type ext_key_type is array (31 downto 0) of std_logic_vector (127 downto 0);
	signal C_cosnt : ext_key_type := (
        0 => x"6ea276726c487ab85d27bd10dd849401",
        1 => x"dc87ece4d890f4b3ba4eb92079cbeb02",
        2 => x"b2259a96b4d88e0be7690430a44f7f03",
        3 => x"7bcd1b0b73e32ba5b79cb140f2551504",
        4 => x"156f6d791fab511deabb0c502fd18105",
        5 => x"a74af7efab73df160dd208608b9efe06",
        6 => x"c9e8819dc73ba5ae50f5b570561a6a07",
        7 => x"f6593616e6055689adfba18027aa2a08",
        8 => x"98fb40648a4d2c31f0dc1c90fa2ebe09",
        9 => x"2adedaf23e95a23a17b518a05e61c10a",
        10 => x"447cac8052ddd8824a92a5b083e5550b",
        11 => x"8d942d1d95e67d2c1a6710c0d5ff3f0c",
        12 => x"e3365b6ff9ae07944740add0087bab0d",
        13 => x"5113c1f94d76899fa029a9e0ac34d40e",
        14 => x"3fb1b78b213ef327fd0e14f071b0400f",
        15 => x"2fb26c2c0f0aacd1993581c34e975410",
        16 => x"41101a5e6342d669c4123cd39313c011",
        17 => x"f33580c8d79a5862237b38e3375cbf12",
        18 => x"9d97f6babbd222da7e5c85f3ead82b13",
        19 => x"547f77277ce987742ea93083bcc24114",
        20 => x"3add015510a1fdcc738e8d936146d515",
        21 => x"88f89bc3a47973c794e789a3c509aa16",
        22 => x"e65aedb1c831097fc9c034b3188d3e17",
        23 => x"d9eb5a3ae90ffa5834ce2043693d7e18",
        24 => x"b7492c48854780e069e99d53b4b9ea19",
        25 => x"056cb6de319f0eeb8e80996310f6951a",
        26 => x"6bcec0ac5dd77453d3a72473cd72011b",
        27 => x"a22641319aecd1fd835291039b686b1c",
        28 => x"cc843743f6a4ab45de752c1346ecff1d",
        29 => x"7ea1add5427c254e391c2823e2a3801e",
        30 => x"1003dba72e345ff6643b95333f27141f",
        31 => x"5ea7d8581e149b61f16ac1459ceda820" );

	signal tmp_R, tmp_L, tmpR_conv, tmp_key: STD_LOGIC_VECTOR (127 downto 0);
	signal tmpR_stb, xsl_load : STD_LOGIC;
	signal count: STD_LOGIC_VECTOR (5 downto 0);

begin
process (clk, load, d_in)
begin
	if (clk'event and clk ='1') then
		if (load = '1') then 
			tmp_key <= C_cosnt(0); 
		    count <= "000001";
			tmp_L <= d_in(127 downto 0); 
			tmp_R <= d_in(255 downto 128); 
			f_out_L <= d_in(127 downto 0);
			f_out_R <= d_in(255 downto 128);

		elsif(tmpR_stb = '1' and count <= "100001") then 
			tmp_key <= C_cosnt(CONV_INTEGER(count));
			
			tmp_L <= tmp_R;
            tmp_R<=tmpR_conv xor tmp_L; 
			if (count = "001001") then
            f_out_R <= tmp_R;
            f_out_L <= tmp_L;
            elsif (count = "010001") then
            f_out_R <= tmp_R;
            f_out_L <= tmp_L;
            elsif (count = "011001") then
            f_out_R <= tmp_R;
            f_out_L <= tmp_L;
            elsif (count = "100001") then
            f_out_R <= tmp_R;
            f_out_L <= tmp_L;
            end if;
			count <= count + 1; 
		end if;
	end if;
end process;

process(clk)
begin
	if(clk'event and clk = '1') then
		if(load = '1') then 
			xsl_load <= '1'; 
		else
			if(count <= "100001") then 
				xsl_load <= tmpR_stb;
			else
				xsl_load <= '0'; 
			end if;
		end if;
	end if;
end process;
conv1: xsl_conv port map (clk, xsl_load, tmp_R, tmp_key, tmpR_conv, tmpR_stb);

f_out_stb <= '1' when (count = "100010" and tmpR_stb = '1') else '0'; 
end Behavioral;