--A full adder with a carry-in bit and a carry-out bit.
--This will be used to build a carry-select adder in the structural implementation.

--number of gates: 5
--two AND, two XOR, one OR

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity csadder is
    Port ( in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           carryin : in  STD_LOGIC;
           carryout : out  STD_LOGIC;
			  sum : out STD_LOGIC);
end csadder;

architecture Behavioral of csadder is

begin
	sum <= in1 XOR in2 XOR carryin;
	carryout <= (in1 AND in2) OR ((in1 XOR in2) AND carryin);

end Behavioral;

