-- mux32.vhd
--authors: Rhett Dobson &&
--         Hamid Dadkhah

--gates used: 5
--1 NOT, 2 AND, 1 OR, plus an extra NOT for ground (??)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32 is
    Port ( inline0 : in  STD_LOGIC_VECTOR (31 downto 0);
           inline1 : in  STD_LOGIC_VECTOR (31 downto 0);
           outline : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC);
end mux32;

architecture Behavioral of mux32 is

begin
	with sel select outline <=
		inline0 when '0',
		inline1 when others;

end Behavioral;

