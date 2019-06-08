library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity s_conv is
Port (dinS : in STD_LOGIC_VECTOR (127 downto 0);
	f_outS : out STD_LOGIC_VECTOR (127 downto 0));
end s_conv;

architecture Behavioral of s_conv is
type Tmem is array (0 to 255) of std_logic_vector(7 downto 0);
constant convS: Tmem:= (
0 => x"fc", 1 => x"ee", 2 => x"dd", 3 => x"11", 4 => x"cf", 5 => x"6e", 6 => x"31", 7 => x"16", 8 => x"fb", 9 => x"c4", 10 => x"fa", 11 => x"da", 12 => x"23", 13 => x"c5", 14 => x"04", 15 => x"4d", 16 => x"e9", 17 => x"77", 18 => x"f0", 19 => x"db", 20 => x"93", 21 => x"2e", 22 => x"99", 23 => x"ba", 24 => x"17", 25 => x"36", 26 => x"f1", 27 => x"bb", 28 => x"14", 29 => x"cd", 30 => x"5f", 31 => x"c1", 32 => x"f9", 33 => x"18", 34 => x"65", 35 => x"5a", 36 => x"e2", 37 => x"5c", 38 => x"ef", 39 => x"21", 40 => x"81", 41 => x"1c", 42 => x"3c", 43 => x"42", 44 => x"8b", 45 => x"01", 46 => x"8e", 47 => x"4f", 48 => x"05", 49 => x"84", 50 => x"02", 51 => x"ae", 52 => x"e3", 53 => x"6a", 54 => x"8f", 55 => x"a0", 56 => x"06", 57 => x"0b", 58 => x"ed", 59 => x"98", 60 => x"7f", 61 => x"d4", 62 => x"d3", 63 => x"1f", 64 => x"eb", 65 => x"34", 66 => x"2c", 67 => x"51", 68 => x"ea", 69 => x"c8", 70 => x"48", 71 => x"ab", 72 => x"f2", 73 => x"2a", 74 => x"68", 75 => x"a2", 76 => x"fd", 77 => x"3a", 78 => x"ce", 79 => x"cc", 80 => x"b5", 81 => x"70", 82 => x"0e", 83 => x"56", 84 => x"08", 85 => x"0c", 86 => x"76", 87 => x"12", 88 => x"bf", 89 => x"72", 90 => x"13", 91 => x"47", 92 => x"9c", 93 => x"b7", 94 => x"5d", 95 => x"87", 96 => x"15", 97 => x"a1", 98 => x"96", 99 => x"29", 100 => x"10", 101 => x"7b", 102 => x"9a", 103 => x"c7", 104 => x"f3", 105 => x"91", 106 => x"78", 107 => x"6f", 108 => x"9d", 109 => x"9e", 110 => x"b2", 111 => x"b1", 112 => x"32",113 => x"75", 114 => x"19", 115 => x"3d", 116 => x"ff", 117 => x"35", 118 => x"8a", 119 => x"7e", 120 => x"6d", 121 => x"54", 122 => x"c6", 123 => x"80", 124 => x"c3", 125 => x"bd", 126 => x"0d", 127 => x"57", 128 => x"df", 129 => x"f5", 130 => x"24", 131 => x"a9", 132 => x"3e", 133 => x"a8", 134 => x"43", 135 => x"c9", 136 => x"d7", 137 => x"79", 138 => x"d6", 139 => x"f6", 140 => x"7c", 141 => x"22", 142 => x"b9", 143 => x"03", 144 => x"e0", 145 => x"0f", 146 => x"ec", 147 => x"de", 148 => x"7a", 149 => x"94", 150 => x"b0", 151 => x"bc", 152 => x"dc", 153 => x"e8", 154 => x"28", 155 => x"50", 156 => x"4e", 157 => x"33", 158 => x"0a", 159 => x"4a", 160 => x"a7", 161 => x"97", 162 => x"60", 163 => x"73", 164 => x"1e", 165 => x"00", 166 => x"62", 167 => x"44", 168 => x"1a", 169 => x"b8", 170 => x"38", 171 => x"82", 172 => x"64", 173 => x"9f", 174 => x"26", 175 => x"41", 176 => x"ad", 177 => x"45", 178 => x"46", 179 => x"92", 180 => x"27", 181 => x"5e", 182 => x"55", 183 => x"2f", 184 => x"8c", 185 => x"a3", 186 => x"a5", 187 => x"7d", 188 => x"69", 189 => x"d5", 190 => x"95", 191 => x"3b", 192 => x"07", 193 => x"58", 194 => x"b3", 195 => x"40", 196 => x"86", 197 => x"ac", 198 => x"1d", 199 => x"f7", 200 => x"30", 201 => x"37", 202 => x"6b", 203 => x"e4", 204 => x"88", 205 => x"d9", 206 => x"e7", 207 => x"89", 208 => x"e1", 209 => x"1b", 210 => x"83", 211 => x"49", 212 => x"4c", 213 => x"3f", 214 => x"f8", 215 => x"fe", 216 => x"8d", 217 => x"53", 218 => x"aa", 219 => x"90", 220 => x"ca", 221 => x"d8", 222 => x"85", 223 => x"61", 224 => x"20", 225 => x"71", 226 => x"67", 227 => x"a4", 228 => x"2d", 229 => x"2b", 230 => x"09", 231 => x"5b", 232 => x"cb", 233 => x"9b", 234 => x"25", 235 => x"d0", 236 => x"be", 237 => x"e5", 238 => x"6c", 239 => x"52", 240 => x"59", 241 => x"a6", 242 => x"74", 243 => x"d2", 244 => x"e6", 245 => x"f4", 246 => x"b4", 247 => x"c0", 248 => x"d1", 249 => x"66", 250 => x"af", 251 => x"c2", 252 => x"39", 253 => x"4b", 254 => x"63", 255 => x"b6" );

begin
process (dinS)
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