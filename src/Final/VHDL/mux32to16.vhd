-- mux32to16.vhd
-- authors: Rhett Dobson &&
--         Hamid Dadkhah

-- This is actually the same as mux32.vhd, but with 16-bit line instead of 32-bit.
-- gates used: 5

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32to16 is
    Port ( inst0 : in  STD_LOGIC_VECTOR (16 downto 0);
           inst1 : in  STD_LOGIC_VECTOR (16 downto 0);
           sel : in  STD_LOGIC;
           oust : out  STD_LOGIC_VECTOR (16 downto 0));
end mux32to16;

architecture Behavioral of mux32to16 is

begin
	with sel select oust <=
		inst0 when '0',
		inst1 when others;

end Behavioral;

