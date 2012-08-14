-- mux2to1.vhd
-- authors: Rhett Dobson &&
--          Hamid Dadkhah

-- Implementation of a 2-to-1 multiplexer, stated literally.

-- gates used: 5
-- 1 NOT, 2 AND, 1 OR, plus an extra NOT for ground (??)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    Port ( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           oot : out  STD_LOGIC);
end mux2to1;

architecture Behavioral of mux2to1 is

begin
	with sel select oot <=
		i0 when '0',
		i1 when others;
		
end Behavioral;

