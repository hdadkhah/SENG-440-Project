--table1.vhd
--authors: Rhett Dobson &&
--         Hamid Dadkhah

-- gLUT1 stands for German Look-Up Table. Originally there were two tables, but
-- for ease of implementation (no need for tri-state buffers) the second was dropped. There was only a 2.55% chance of needing it anyway...

-- This is a simple 11-to-8 decoder unit that turns our 11-bit max-length Huffman codes
-- and returns 8-bit ASCII values (1 byte), as well as how long the code actually is
-- (it's probably shorter than 11 bits)

-- gates used: there are two decoder blocks, and each has:
--  1 three-input AND gate with all three input lines inverted
--  1 four-input AND gate, one has only the fourth input line inverted
--  and 1 AND gate. so 6 gates
-- These results feed into 5 more gates which generate the 8-bit ASCII result, which are  
--  1 NOT
--  2 two-input OR (one has one of its inputs inverted)
--  2 three-input OR (the third input is inverted)

-- So the total gates used is either 11 if every gate is made with the specific inversions
-- or 17 if inverters are used to invert the necessary inputs.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gLUT1 is
    Port ( input : in  STD_LOGIC_VECTOR (10 downto 0);
           ascii_result : out  STD_LOGIC_VECTOR (7 downto 0);
           code_length: out  STD_LOGIC_VECTOR (3 downto 0));
end gLUT1;

--Lookup Table.
--possible timesaver: if code starts with "11111" use a secondary table
--to look up remaining 6 bits

architecture Behavioral of gLUT1 is

begin
	process (input)
	begin
		if (input(10 downto 8)="001") then --check first three bits for this symbol
			ascii_result <= "00010000"; --' ', ASCII 32, when 001
			code_length <= "0011"; --3 bits
		elsif (input(10 downto 8)="010") then
			ascii_result <= "01100101"; --'e', ASCII 101
			code_length <= "0011"; 
		elsif (input(10 downto 7)="0000") then
			ascii_result <= "01101110"; --'n', ASCII 110
			code_length <= "0100"; 	
		elsif (input(10 downto 7)="0110") then
			ascii_result <= "01101001"; --'i', ASCII 105
			code_length <= "0100";
		elsif (input(10 downto 7)="1000") then
			ascii_result <= "01110011"; --'s', ASCII 115
			code_length <= "0100"; 
		elsif (input(10 downto 7)="1001") then
			ascii_result <= "01110010"; --'r', ASCII 114
			code_length <= "0100"; 
		elsif (input(10 downto 7)="1010") then
			ascii_result <= "01100001"; --'a', ASCII 97
			code_length <= "0100"; 
		elsif (input(10 downto 7)="1100") then
			ascii_result <= "01110100"; --'t', ASCII 116
			code_length <= "0100"; 
		elsif (input(10 downto 7)="1110") then
			ascii_result <= "01100100"; --'d', ASCII 100
			code_length <= "0100"; 
		elsif (input(10 downto 6)="00010") then
			ascii_result <= "01101000"; --'h', ASCII 104
			code_length <= "0101"; 
		elsif (input(10 downto 6)="00011") then
			ascii_result <= "01110101"; --'u', ASCII 117
			code_length <= "0101";
		elsif (input(10 downto 6)="10110") then
			ascii_result <= "01101000"; --'l', ASCII 108
			code_length <= "0101";
		elsif (input(10 downto 6)="10111") then
			ascii_result <= "01100011"; --'c', ASCII 99
			code_length <= "0101";
		elsif (input(10 downto 6)="11010") then
			ascii_result <= "01100111"; --'g', ASCII 103
			code_length <= "0101";
		elsif (input(10 downto 6)="11011") then
			ascii_result <= "01101101"; --'m', ASCII 109
			code_length <= "0101";
		elsif (input(10 downto 6)="11110") then
			ascii_result <= "01101111"; --'o', ASCII 111
			code_length <= "0101";
		elsif (input(10 downto 5)="011101") then
			ascii_result <= "01110111"; --'w', ASCII 119
			code_length <= "0110";
		elsif (input(10 downto 5)="011110") then
			ascii_result <= "01100010"; --'b', ASCII 98
			code_length <= "0110";
		elsif (input(10 downto 5)="011111") then
			ascii_result <= "01100110"; --'f', ASCII 102
			code_length <= "0110";
		elsif (input(10 downto 5)="111111") then
			ascii_result <= "01100111"; --'k', ASCII 107
			code_length <= "0110";
		elsif (input(10 downto 4)="0111000") then
			ascii_result <= "01111010"; --'z', ASCII 122
			code_length <= "0111";
		elsif (input(10 downto 4)="0111001") then
			ascii_result <= "01110000"; --'p', ASCII 112
			code_length <= "0111";
		elsif (input(10 downto 4)="1111101") then
			ascii_result <= "01110110"; --'v', ASCII 118
			code_length <= "0111";	
		elsif (input(10 downto 3)="11111001") then
			ascii_result <= "11100001"; --sharp S, ASCII 225
			code_length <= "1000";
		elsif (input(10 downto 2)="111110000") then
			ascii_result <= "01101010"; --'j', ASCII 106
			code_length <= "1001";
		elsif (input(10 downto 1)="1111100011") then
			ascii_result <= "01111001"; --'y', ASCII 121
			code_length <= "1010";
		elsif (input(10 downto 0)="11111000100") then
			ascii_result <= "01110000"; --'x', ASCII 120
			code_length <= "1011";
		else --(input(10 downto 0)="11111000101") then
			ascii_result <= "01110001"; --'q', ASCII 113
			code_length <= "1011";
		end if;
	end process;
end Behavioral;

