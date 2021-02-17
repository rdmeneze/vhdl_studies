library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity FIFO8x9 is
   port(
      clk, rst:		in std_logic; --normal clk and reset
      RdPtrClr, WrPtrClr:	in std_logic; --these will zero out the wrptr and rdptr
      RdInc, WrInc:	in std_logic; --these will dictate an increment of the wrptr and rdptr but seems unnecessary since rden and wren should be dictating this
      DataIn:	 in std_logic_vector(8 downto 0); --8 bit data that will be loaded on FIFO stack when writing
      DataOut: out std_logic_vector(8 downto 0); --8 bit data that will be released from FIFO stack when reading
      rden, wren: in std_logic --bits which dictate when read and write processes occur
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
	type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);  -- makes use of VHDL’s enumerated type
	signal fifo:  fifo_array; --holds all the data in the fifo
	signal wrptr : unsigned(2 downto 0) :="000"; --holds the depth position of where data will be written to
	signal rdptr: unsigned(2 downto 0):="000"; --holds the depth position of where data will be read from
	signal en: std_logic_vector(7 downto 0) :="00000000"; --Trash Really dont need this, can use an index instead. Intended to map to depth location for write process
	signal dmuxout: std_logic_vector(8 downto 0) :="000000000"; --Trash really dont need this but this is intended to be output signal which uses rden to select DataOut

begin

------------------------writing to and clearing FIFO Process--------------------------
FIFO_WRITE: process(clk,rst)
begin
	if rst = '1' then --reset must do 3 things: clear fifo elements, zero rdptr, and zero wrptr
		for i in 7 downto 0 loop
			fifo(i) <= (others => '0'); --this clears each element of the fifo one at a time
		end loop;
		wrptr <= (others => '0'); -- send wrptr to point at first element in fifo
		rdptr <= (others => '0'); -- sends rdptr to point at the first element in fifo
	elsif rising_edge(clk) then
		if wren = '1' then
			fifo(to_integer(wrptr)) <= DataIn; --writes input data to fifo at location indicated by the wrptr
		else 
			fifo(to_integer(wrptr)) <= fifo(to_integer(wrptr)); --keeps us from using memory. always have to show what occurs for other cases
		end if;
		if RdPtrClr = '1' then
			rdptr <= (others => '0'); -- sends rdptr to point at the first element in fifo
		elsif RdInc = '1' then
			rdptr <= rdptr + 1; --increment rdptr if enabled (dont know why rden cant handle this? but go off with the "no directions" approach profs, good job)
		end if;
		if WrPtrClr = '1' then
			wrptr <= (others => '0'); -- sends wrptr to point at the first element in fifo
		elsif WrInc = '1' then
			wrptr <= wrptr + 1; --increment wrptr if enabled 
		end if;
	end if;
end process;

------------------------reading data from FIFO buffer--------------------------
data_read: process(rden,rdptr)
begin
	if rden = '1' then 
		DataOut <= fifo(to_integer(rdptr)); --load the fifo element specified by rdptr into the DataOut when rden is 1
	else 
		DataOut <= (others => 'Z'); --high impedance if read isnt enabled
	end if;
end process;
end RTL;