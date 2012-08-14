--latch32.vhd
--authors: Rhett Dobson &&
--         Hamid Dadkhah

--Though the entity is called register11, it's more like a 32-bit latch.
--This unit stores 32 bits and asynchronously waits for a signal to push it out
--to the barrel shifter, then load new values from the 32x 2to1 MUX array.
--Some are from the outside world, some are from the barrel shifter.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register11 is
    Port ( reg_in : in  STD_LOGIC_VECTOR (31 downto 0); --has the 32x 2to1 MUX array in front of it
           reg_out : out  STD_LOGIC_VECTOR (31 downto 0); --sent to barrel shifter
           load : in  STD_LOGIC;
			  push : in  STD_LOGIC;
			  cloak : in STD_LOGIC;
           send_reset : out  STD_LOGIC);
end register11;

architecture Behavioral of register11 is

	signal stored : STD_LOGIC_VECTOR (31 downto 0); --the stored values in the register
	
begin
	
	process 
	begin
			
		if (load = '1') then
			stored <= reg_in;
		   send_reset <= '0'; --load bit from shift-decoder should change shortly after
		end if;
	
		wait on cloak until push = '1'; --wait for load to finish
		send_reset <= '1';
		reg_out <= stored;
		
	end process;
	
end Behavioral;

