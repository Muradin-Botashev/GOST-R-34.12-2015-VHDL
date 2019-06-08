library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity xsl_conv is
Port (clk : in STD_LOGIC;
	load : in STD_LOGIC;
	d_in : in STD_LOGIC_VECTOR (127 downto 0);
	C_cosnt : in STD_LOGIC_VECTOR (127 downto 0);
	f_out : out STD_LOGIC_VECTOR (127 downto 0);
	f_out_stb : out STD_LOGIC );
end xsl_conv;

architecture Behavioral of xsl_conv is
signal tmpX, tmpS, tmpL: STD_LOGIC_VECTOR (127 downto 0);
component s_conv
port (dinS: in STD_LOGIC_VECTOR (127 downto 0);
	f_outS: out STD_LOGIC_VECTOR (127 downto 0) );
end component;

component l_conv
port (clk, load: in STD_LOGIC;
	dinL: in STD_LOGIC_VECTOR (127 downto 0);
	fin_outL: out STD_LOGIC_VECTOR (127 downto 0);
	fin_out_stbL : out STD_LOGIC );
end component;

begin
tmpX<=d_in xor C_cosnt;
convS: s_conv port map (tmpX, tmpS);
convL: l_conv port map (clk, load, tmpS, f_out, f_out_stb);
end Behavioral;