--dk_shift.vhd
--authors: Rhett Dobson &&
--         Hamid Dadkhah

--32-bit barrel shifter, named in honour of a certain Kong. The input shift acts as 
--an absolute reference that sends an image of the bits in the unit down the output line.
--Because the lookup table only uses 11 bits, the shifter only performs logical left
--shifts and fills the lower bits with zeroes.

--gates used: 5 * mux32
-- == 1 tristate buffer + a 'MUX1' VHDL internal construct.
-- a MUX can be made out of 1 inverter, 2 ANDs and 1 OR.
-- so 5*4 = 20 gates.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dk_shift is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           shift : in  STD_LOGIC_VECTOR (4 downto 0)); --acts like an absolute reference
end dk_shift;

architecture Behavioral of dk_shift is
  function make_integer(sig : std_logic_vector) return integer is
    variable num : integer := 0;  -- descending sig as unsigned
  begin
    for i in sig'range loop
      if sig(i)='1' then
        num := num*2+1;
      else
        num := num*2;
      end if;
    end loop; 
    return num;
  end function make_integer;
begin
   
  process(input, shift)
    variable intshift : integer;
    variable output_buffer : std_logic_vector(31 downto 0);
  begin
    
    intshift := make_integer(shift);

		output_buffer := input((31 - intshift) downto 0) & (intshift - 1 downto 0 => '0'); --fill new slots with 0s
		output <= output_buffer(31 downto 21); --only the most significant 11 bits are sent to table
	 
  end process;

end Behavioral;

--Well, behavioral didn't like synthesizing (when I tried outputting 11 bits instead of 32)
--so let's try a structural implementation...

architecture structural of dk_shift is
	signal layer0  : STD_LOGIC_VECTOR(31 downto 0);
	signal layer0s : STD_LOGIC_VECTOR(31 downto 0); --the other input to the same layer of MUX, but shifted
	signal layer1  : STD_LOGIC_VECTOR(31 downto 0);
	signal layer1s : STD_LOGIC_VECTOR(31 downto 0); 
	signal layer2  : STD_LOGIC_VECTOR(31 downto 0); 
	signal layer2s : STD_LOGIC_VECTOR(31 downto 0); 
	signal layer3  : STD_LOGIC_VECTOR(31 downto 0);
	signal layer3s : STD_LOGIC_VECTOR(31 downto 0); 
	signal layer4  : STD_LOGIC_VECTOR(31 downto 0);
	signal layer4s : STD_LOGIC_VECTOR(31 downto 0); 
	
	component mux32
		Port ( inline0 : in  STD_LOGIC_VECTOR (31 downto 0);
           inline1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outline : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC);
	end component;
	
begin
	--bus lines
	layer0w: layer0s <= input(30 downto 0) & '0'; --includes the zeros that get appended in later shifts
	layer1w: layer1s <= layer0(29 downto 0) & "00"; 	
	layer2w: layer2s <= layer1(27 downto 0) & "0000";	
	layer3w: layer3s <= layer2(23 downto 0) & "00000000"; 
	layer4w: layer4s <= layer3(15 downto 0) & "0000000000000000"; 
	
	--multiplexers
	layer0m: mux32 port map (inline0=>input, inline1=>layer0s, sel=>shift(0), outline=>layer0);
	layer1m: mux32 port map (inline0=>layer0, inline1=>layer1s, sel=>shift(1), outline=>layer1);
	layer2m: mux32 port map (inline0=>layer1, inline1=>layer2s, sel=>shift(2), outline=>layer2);
	layer3m: mux32 port map (inline0=>layer2, inline1=>layer3s, sel=>shift(3), outline=>layer3);
	layer4m: mux32 port map (inline0=>layer3, inline1=>layer4s, sel=>shift(4), outline=>output);
	
end architecture structural;
