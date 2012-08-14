--shift_decoder.vhd
--authors: Rhett Dobson &&
--         Hamid Dadkhah

--This decoder is only actually needed once the 5-bit shift
--from the accumulator becomes > 20. At that point, new bits
--should be brought in from the outside world in the slots that
--were filled in with zeroes from shifting.

--Why 20 as a safeguard? If 21 bits have been encoded and the last 11
--bits hit a match in the lookup table, the value of shift will roll over to
--"00000" and the barrel shifter will freeze like that forever. Therefore decoding
--exactly 32 bits is to be avoided.

--the first two bits are for load and push, to be sent to the register.

--gates used: unknown. VHDL has modeled the truth table as a large ROM chip with
--only 1 inverter leading up to it.
--given that the "others" case is very large, there would be many "don't care"
--conditions on the Karnaugh map, leading to a sprawling mess of AND and OR gates.
--to save silicon area, stick with the ROM chip. 2 components.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_decoder is
    Port ( shift : in  STD_LOGIC_VECTOR (4 downto 0);
           decoded : out  STD_LOGIC_VECTOR (33 downto 0));
           --send_load : out  STD_LOGIC;
           --send_push : out  STD_LOGIC);
end shift_decoder;

architecture Behavioral of shift_decoder is

begin
	
	--examples:
	--if (shift = "00000") then
		--decoded <= (31 downto 0 => '1'); --no shift? keep everything in the barrel shifter the same
	--elsif (shift = "00001") then
		--decoded <= (31 downto 1 => '1') & (1 downto 0 => '0'); --shift of one has one dead bit at the end

	with shift select decoded <=
		"11" & (31 downto 21 => '1') & (20 downto 0 => '0') when "10100", --20
		"11" & (31 downto 22 => '1') & (21 downto 0 => '0') when "10101", --21
		"11" & (31 downto 23 => '1') & (22 downto 0 => '0') when "10110", --22
		"11" & (31 downto 24 => '1') & (23 downto 0 => '0') when "10111",
		"11" & (31 downto 25 => '1') & (24 downto 0 => '0') when "11000",
		"11" & (31 downto 26 => '1') & (25 downto 0 => '0') when "11001",
		"11" & (31 downto 27 => '1') & (26 downto 0 => '0') when "11010",
		"11" & (31 downto 28 => '1') & (27 downto 0 => '0') when "11011",
		"11" & (31 downto 29 => '1') & (28 downto 0 => '0') when "11100",
		"11" & (31 downto 30 => '1') & (29 downto 0 => '0') when "11101",
		"11" & '1'                   & (30 downto 0 => '0') when "11110",  
		"11" &                         (31 downto 0 => '0') when "11111", --31
		"00" & (31 downto 0 => '1') when others; --don't do any loading/pushing until shift gets too big
		
	   

end Behavioral;

