library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity s_conv is
Port ( clk : in STD_LOGIC;
	dinS : in STD_LOGIC_VECTOR (127 downto 0);
	f_outS : out STD_LOGIC_VECTOR (127 downto 0));
end s_conv;

architecture Behavioral of s_conv is
type Tmem is array (0 to 255) of std_logic_vector(7 downto 0);
constant convS: Tmem:= (
0 => x"A5", 1 => x"2D", 2 => x"32", 3 => x"8F", 4 => x"0E", 5 => x"30", 6 => x"38", 7 => x"C0", 8 => x"54", 9 => x"E6", 10 => x"9E", 11 => x"39", 12 => x"55", 13 => x"7E", 14 => x"52", 15 => x"91", 16 => x"64", 17 => x"03", 18 => x"57", 19 => x"5A", 20 => x"1C", 21 => x"60", 22 => x"07", 23 => x"18", 24 => x"21", 25 => x"72", 26 => x"A8", 27 => x"D1", 28 => x"29", 29 => x"C6", 30 => x"A4", 31 => x"3F", 32 => x"E0", 33 => x"27", 34 => x"8D", 35 => x"0C", 36 => x"82", 37 => x"EA", 38 => x"AE", 39 => x"B4", 40 => x"9A", 41 => x"63", 42 => x"49", 43 => x"E5", 44 => x"42", 45 => x"E4", 46 => x"15", 47 => x"B7", 48 => x"C8", 49 => x"06", 50 => x"70", 51 => x"9D", 52 => x"41", 53 => x"75", 54 => x"19", 55 => x"C9", 56 => x"AA", 57 => x"FC", 58 => x"4D", 59 => x"BF", 60 => x"2A", 61 => x"73", 62 => x"84", 63 => x"D5", 64 => x"C3", 65 => x"AF", 66 => x"2B", 67 => x"86", 68 => x"A7", 69 => x"B1", 70 => x"B2", 71 => x"5B", 72 => x"46", 73 => x"D3", 74 => x"9F", 75 => x"FD", 76 => x"D4", 77 => x"0F", 78 => x"9C", 79 => x"2F", 80 => x"9B", 81 => x"43", 82 => x"EF", 83 => x"D9", 84 => x"79", 85 => x"B6", 86 => x"53", 87 => x"7F", 88 => x"C1", 89 => x"F0", 90 => x"23", 91 => x"E7", 92 => x"25", 93 => x"5E", 94 => x"B5", 95 => x"1E", 96 => x"A2", 97 => x"DF", 98 => x"A6", 99 => x"FE", 100 => x"AC", 101 => x"22", 102 => x"F9", 103 => x"E2", 104 => x"4A", 105 => x"BC", 106 => x"35", 107 => x"CA", 108 => x"EE", 109 => x"78", 110 => x"05", 111 => x"6B", 112 => x"51", 113 => x"E1", 114 => x"59", 115 => x"A3", 116 => x"F2", 117 => x"71", 118 => x"56", 119 => x"11", 120 => x"6A", 121 => x"89", 122 => x"94", 123 => x"65", 124 => x"8C", 125 => x"BB", 126 => x"77", 127 => x"3C", 128 => x"7B", 129 => x"28", 130 => x"AB", 131 => x"D2", 132 => x"31", 133 => x"DE", 134 => x"C4", 135 => x"5F", 136 => x"CC", 137 => x"CF", 138 => x"76", 139 => x"2C", 140 => x"B8", 141 => x"D8", 142 => x"2E", 143 => x"36", 144 => x"DB", 145 => x"69", 146 => x"B3", 147 => x"14", 148 => x"95", 149 => x"BE", 150 => x"62", 151 => x"A1", 152 => x"3B", 153 => x"16", 154 => x"66", 155 => x"E9", 156 => x"5C", 157 => x"6C", 158 => x"6D", 159 => x"AD", 160 => x"37", 161 => x"61", 162 => x"4B", 163 => x"B9", 164 => x"E3", 165 => x"BA", 166 => x"F1", 167 => x"A0", 168 => x"85", 169 => x"83", 170 => x"DA", 171 => x"47", 172 => x"C5", 173 => x"B0", 174 => x"33", 175 => x"FA", 176 => x"96", 177 => x"6F", 178 => x"6E", 179 => x"C2", 180 => x"F6", 181 => x"50", 182 => x"FF", 183 => x"5D", 184 => x"A9", 185 => x"8E", 186 => x"17", 187 => x"1B", 188 => x"97", 189 => x"7D", 190 => x"EC", 191 => x"58", 192 => x"F7", 193 => x"1F", 194 => x"FB", 195 => x"7C", 196 => x"09", 197 => x"0D", 198 => x"7A", 199 => x"67", 200 => x"45", 201 => x"87", 202 => x"DC", 203 => x"E8", 204 => x"4F", 205 => x"1D", 206 => x"4E", 207 => x"04", 208 => x"EB", 209 => x"F8", 210 => x"F3", 211 => x"3E", 212 => x"3D", 213 => x"BD", 214 => x"8A", 215 => x"88", 216 => x"DD", 217 => x"CD", 218 => x"0B", 219 => x"13", 220 => x"98", 221 => x"02", 222 => x"93", 223 => x"80", 224 => x"90", 225 => x"D0", 226 => x"24", 227 => x"34", 228 => x"CB", 229 => x"ED", 230 => x"F4", 231 => x"CE", 232 => x"99", 233 => x"10", 234 => x"44", 235 => x"40", 236 => x"92", 237 => x"3A", 238 => x"01", 239 => x"26", 240 => x"12", 241 => x"1A", 242 => x"48", 243 => x"68", 244 => x"F5", 245 => x"81", 246 => x"8B", 247 => x"C7", 248 => x"D6", 249 => x"20", 250 => x"0A", 251 => x"08", 252 => x"00", 253 => x"4C", 254 => x"D7", 255 => x"74" );

begin
process (clk, dinS)
variable i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15 : integer;
begin
i0 := CONV_INTEGER(dinS(127 downto 120));
i1 := CONV_INTEGER(dinS(119 downto 112));
i2 := CONV_INTEGER(dinS(111 downto 104));
i3 := CONV_INTEGER(dinS(103 downto 96));
i4 := CONV_INTEGER(dinS(95 downto 88));
i5 := CONV_INTEGER(dinS(87 downto 80));
i6 := CONV_INTEGER(dinS(79 downto 72));
i7 := CONV_INTEGER(dinS(71 downto 64));
i8 := CONV_INTEGER(dinS(63 downto 56));
i9 := CONV_INTEGER(dinS(55 downto 48));
i10 := CONV_INTEGER(dinS(47 downto 40));
i11 := CONV_INTEGER(dinS(39 downto 32));
i12 := CONV_INTEGER(dinS(31 downto 24));
i13 := CONV_INTEGER(dinS(23 downto 16));
i14 := CONV_INTEGER(dinS(15 downto 8));
i15 := CONV_INTEGER(dinS(7 downto 0));
f_outS <= convS(i0) & convS(i1) & convS(i2) & convS(i3) & convS(i4) & convS(i5) & convS(i6) & convS(i7) & convS(i8) & convS(i9) & convS(i10) & convS(i11) & convS(i12) & convS(i13) & convS(i14) & convS(i15);
end process;
end Behavioral;