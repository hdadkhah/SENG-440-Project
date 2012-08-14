-- Huffman decoder - Top module
-- authors: Rhett Dobson &&
--          Hamid Dadkhah

-- This is the top module that brings all the parts together.
-- The 32-bit input stream "bits" is an arbitrary window of 32 bits dumped in from
-- somewhere in the real world.
-- The 8-bit output stream "ascii" is a placeholder for the byte returned in ascii_result
-- from table1.vhd.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity huffman_decoder is
    Port ( bits  : in  STD_LOGIC_VECTOR (31 downto 0);
           ascii : out  STD_LOGIC_VECTOR (7 downto 0);
	   global_clock : in STD_LOGIC);
end huffman_decoder;

architecture structural of huffman_decoder is

	--34 bit buses/vectors
	signal shift_decoded : STD_LOGIC_VECTOR(33 downto 0); --from the 5-to-34 decoder

	--32 bit buses/vectors
	signal in_fromworld : STD_LOGIC_VECTOR(31 downto 0); --32 bits dumped in from the real world
	signal in_latch : STD_LOGIC_VECTOR(31 downto 0); --has the MUX array in front of it
	signal in_dk: STD_LOGIC_VECTOR(31 downto 0); --input to barrel shifter
	signal out_dk : STD_LOGIC_VECTOR(31 downto 0); --copy of output from dk_shift
	
	--16 bit buses/vectors
	signal selected_carry : STD_LOGIC_VECTOR(16 downto 0);
	
	--11 bit buses/vectors
	signal in_table: STD_LOGIC_VECTOR(10 downto 0);
	
	--5 bit buses/vectors
	signal shift_dk : STD_LOGIC_VECTOR(4 downto 0);
	signal shift_decodethis : STD_LOGIC_VECTOR(4 downto 0);
	
	--4 bit buses/vectors
	signal decoded_length : STD_LOGIC_VECTOR(3 downto 0);
	
	--single lines --
	signal alwayson: STD_LOGIC; --always '1'
	signal reset_accu : STD_LOGIC;
	
	--inputs to latch
	signal ri0: STD_LOGIC;
	signal ri1: STD_LOGIC;
	signal ri2: STD_LOGIC;
	signal ri3: STD_LOGIC;
	signal ri4: STD_LOGIC;
	signal ri5: STD_LOGIC;
	signal ri6: STD_LOGIC;
	signal ri7: STD_LOGIC;
	signal ri8: STD_LOGIC;
	signal ri9: STD_LOGIC;
	signal ri10: STD_LOGIC;
	signal ri11: STD_LOGIC;
	signal ri12: STD_LOGIC;
	signal ri13: STD_LOGIC;
	signal ri14: STD_LOGIC;
	signal ri15: STD_LOGIC;
	signal ri16: STD_LOGIC;
	signal ri17: STD_LOGIC;
	signal ri18: STD_LOGIC;
	signal ri19: STD_LOGIC;
	signal ri20: STD_LOGIC;
	signal ri21: STD_LOGIC;
	signal ri22: STD_LOGIC;
	signal ri23: STD_LOGIC;
	signal ri24: STD_LOGIC;
	signal ri25: STD_LOGIC;
	signal ri26: STD_LOGIC;
	signal ri27: STD_LOGIC;
	signal ri28: STD_LOGIC;
	signal ri29: STD_LOGIC;
	signal ri30: STD_LOGIC;
	signal ri31: STD_LOGIC;
	
	-- COMPONENTS --	
	component mux2to1
	Port ( i0  : in  STD_LOGIC;
          i1  : in  STD_LOGIC;
          oot : out STD_LOGIC;
          sel : in  STD_LOGIC);
	end component;
	
	component mux32
	Port ( inline0 : in  STD_LOGIC_VECTOR (31 downto 0);
          inline1 : in  STD_LOGIC_VECTOR (31 downto 0);
          outline : out STD_LOGIC_VECTOR (31 downto 0);
          sel     : in  STD_LOGIC);
	end component;
	
	component mux32to16
	Port ( inst0 : in  STD_LOGIC_VECTOR (31 downto 0);
          inst1 : in  STD_LOGIC_VECTOR (31 downto 0);
          oust  : out STD_LOGIC_VECTOR (31 downto 0);
          sel   : in  STD_LOGIC);
	end component;
	
	component register11
	Port ( reg_in     : in  STD_LOGIC_VECTOR (31 downto 0); --has the 32x 2to1 MUX array in front of it
          reg_out    : out STD_LOGIC_VECTOR (31 downto 0); --sent to barrel shifter
          load       : in  STD_LOGIC;
			 push       : in  STD_LOGIC;
			 cloak      : in  STD_LOGIC;
          send_reset : out STD_LOGIC);
	end component;

	component gLUT1
	Port ( input        : in  STD_LOGIC_VECTOR (10 downto 0);
			 code_length  : out STD_LOGIC_VECTOR (3 downto 0);
          ascii_result : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component accumulator is
   Port ( clk        : in  STD_LOGIC;
         reset         : in  STD_LOGIC;
         do_add        : in  STD_LOGIC; -- enable
         codelength_in : in  STD_LOGIC_VECTOR (3 downto 0);
         shift_out     : out STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component shift_decoder is
	Port ( shift   : in  STD_LOGIC_VECTOR (4 downto 0);
          decoded : out STD_LOGIC_VECTOR (33 downto 0));
	end component;

	component dk_shift is
    Port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0);
           shift  : in  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
begin
	initial_input: in_fromworld <= bits;
	alwaysone: alwayson <= '1';
	
	-- 32x 2-to-1 MUX array, input to latch32
	Rm0: mux2to1 port map (i0=>in_fromworld(0), i1=>out_dk(0), sel=>shift_decoded(0), oot=>ri0); --0 for outside world, 1 for barrel shifter
	Rm1: mux2to1 port map (i0=>in_fromworld(1), i1=>out_dk(1), sel=>shift_decoded(1), oot=>ri1);
	Rm2: mux2to1 port map (i0=>in_fromworld(2), i1=>out_dk(2), sel=>shift_decoded(2), oot=>ri2);
	Rm3: mux2to1 port map (i0=>in_fromworld(3), i1=>out_dk(3), sel=>shift_decoded(3), oot=>ri3);
	Rm4: mux2to1 port map (i0=>in_fromworld(4), i1=>out_dk(4), sel=>shift_decoded(4), oot=>ri4);
	Rm5: mux2to1 port map (i0=>in_fromworld(5), i1=>out_dk(5), sel=>shift_decoded(5), oot=>ri5);
	Rm6: mux2to1 port map (i0=>in_fromworld(6), i1=>out_dk(6), sel=>shift_decoded(6), oot=>ri6);
	Rm7: mux2to1 port map (i0=>in_fromworld(7), i1=>out_dk(7), sel=>shift_decoded(7), oot=>ri7);
	Rm8: mux2to1 port map (i0=>in_fromworld(8), i1=>out_dk(8), sel=>shift_decoded(8), oot=>ri8);
	Rm9: mux2to1 port map (i0=>in_fromworld(9), i1=>out_dk(9), sel=>shift_decoded(9), oot=>ri9);
	Rm10: mux2to1 port map (i0=>in_fromworld(10), i1=>out_dk(10), sel=>shift_decoded(10), oot=>ri10);
	Rm11: mux2to1 port map (i0=>in_fromworld(11), i1=>out_dk(11), sel=>shift_decoded(11), oot=>ri11);
	Rm12: mux2to1 port map (i0=>in_fromworld(12), i1=>out_dk(12), sel=>shift_decoded(12), oot=>ri12);
	Rm13: mux2to1 port map (i0=>in_fromworld(13), i1=>out_dk(13), sel=>shift_decoded(13), oot=>ri13);
	Rm14: mux2to1 port map (i0=>in_fromworld(14), i1=>out_dk(14), sel=>shift_decoded(14), oot=>ri14);
	Rm15: mux2to1 port map (i0=>in_fromworld(15), i1=>out_dk(15), sel=>shift_decoded(15), oot=>ri15);
	Rm16: mux2to1 port map (i0=>in_fromworld(16), i1=>out_dk(16), sel=>shift_decoded(16), oot=>ri16);
	Rm17: mux2to1 port map (i0=>in_fromworld(17), i1=>out_dk(17), sel=>shift_decoded(17), oot=>ri17);
	Rm18: mux2to1 port map (i0=>in_fromworld(18), i1=>out_dk(18), sel=>shift_decoded(18), oot=>ri18);
	Rm19: mux2to1 port map (i0=>in_fromworld(19), i1=>out_dk(19), sel=>shift_decoded(19), oot=>ri19);
	Rm20: mux2to1 port map (i0=>in_fromworld(20), i1=>out_dk(20), sel=>shift_decoded(20), oot=>ri20);
	Rm21: mux2to1 port map (i0=>in_fromworld(21), i1=>out_dk(21), sel=>shift_decoded(21), oot=>ri21);
	Rm22: mux2to1 port map (i0=>in_fromworld(22), i1=>out_dk(22), sel=>shift_decoded(22), oot=>ri22);
	Rm23: mux2to1 port map (i0=>in_fromworld(23), i1=>out_dk(23), sel=>shift_decoded(23), oot=>ri23);
	Rm24: mux2to1 port map (i0=>in_fromworld(24), i1=>out_dk(24), sel=>shift_decoded(24), oot=>ri24);
	Rm25: mux2to1 port map (i0=>in_fromworld(25), i1=>out_dk(25), sel=>shift_decoded(25), oot=>ri25);
	Rm26: mux2to1 port map (i0=>in_fromworld(26), i1=>out_dk(26), sel=>shift_decoded(26), oot=>ri26);
	Rm27: mux2to1 port map (i0=>in_fromworld(27), i1=>out_dk(27), sel=>shift_decoded(27), oot=>ri27);
	Rm28: mux2to1 port map (i0=>in_fromworld(28), i1=>out_dk(28), sel=>shift_decoded(28), oot=>ri28);
	Rm29: mux2to1 port map (i0=>in_fromworld(29), i1=>out_dk(29), sel=>shift_decoded(29), oot=>ri29);
	Rm30: mux2to1 port map (i0=>in_fromworld(30), i1=>out_dk(30), sel=>shift_decoded(30), oot=>ri30);
	Rm31: mux2to1 port map (i0=>in_fromworld(31), i1=>out_dk(31), sel=>shift_decoded(31), oot=>ri31);
	
	--the outputs from the 32x MUX array, converted into a 32-bit bus
	latch_bridge: in_latch <= ri31 & ri30 & ri29 & ri28 & ri27 & ri26 & ri25 & ri24 & ri23 & ri22 & ri21 & ri20 & ri19 & ri18 & ri17 & ri16 & ri15 & ri14 & ri13 & ri12 & ri11 & ri10 & ri9 & ri8 & ri7 & ri6 & ri5 & ri4 & ri3 & ri2 & ri1 & ri0;
	
	LATCH: register11 port map (reg_in=>in_latch, load=>shift_decoded(32), push=>shift_decoded(33), cloak=>global_clock, send_reset=>reset_accu, reg_out=>in_dk);
	
	barrel_shifter: dk_shift port map (input=>in_dk, shift=>shift_dk, output=>out_dk);
	
	lookup_table: gLUT1 port map (input=>out_dk(31 downto 21), code_length=>decoded_length, ascii_result=>ascii);
	
	acumudu: accumulator port map (clk=>global_clock, reset=>reset_accu, do_add=>alwayson, codelength_in=>decoded_length, shift_out=>shift_dk);
	
	copy_shift: shift_decodethis <= shift_dk;
	
	bigdecoder: shift_decoder port map (shift=>shift_decodethis, decoded=>shift_decoded);

end structural;

