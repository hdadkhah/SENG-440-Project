--accumulator.vhd 

--adds up code_lengths received from the lookup table.
--code_length is 4 bits, but the accumulator holds up to 5 bits,
--which dk_shift uses to do its absolute-reference logical left shifts.

--gates used: adder + D flip flop with clear.
--given our implementation of the adder will be carry select, that's:
-- 3 adders (5 gates each)
-- + one 2-to-1 multiplexer (4 gates)
-- + a FDCE is 5 gates: 2 three-input NANDs, 2 two-input NANDs and a NOT.
--   (see reference [8] for above)
-- = 24 gates total.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity accumulator is
  Port ( clk         : in STD_LOGIC;
         reset         : in STD_LOGIC;
         do_add        : in STD_LOGIC; -- enable
         codelength_in : in STD_LOGIC_VECTOR (3 downto 0);
         shift_out     : out STD_LOGIC_VECTOR (4 downto 0));
end accumulator;

architecture Behavioral of accumulator is

begin
	
	process (reset, clk) --reset'event is part of this process beginning
		variable soFar : STD_LOGIC_VECTOR (4 downto 0); --running total stored in register
	begin
	 --todo: make sure reset finishes before barrel shifter computes
		if (reset = '1') then -- need to make sure reset is edge-triggered or the accumulator will be zero forever
			shift_out <= "00000"; -- initialize the output and the running total to 0
			soFar := "00000";		
		elsif (clk'event and clk = '1') then
			if do_add = '1' then
				soFar := soFar + codelength_in;
			else
				soFar := soFar; -- don't add if do_add is off
			end if;
		end if;
		shift_out <= soFar;
	end process;
	
end Behavioral;

--todo: add in architectural carry select adder system
