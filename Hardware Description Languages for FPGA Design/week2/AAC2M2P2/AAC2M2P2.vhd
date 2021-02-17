LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM128_32 is
	generic (AddressWidth : integer := 7);
	port (	Clock : in std_logic := '1'; --clock
			address : in std_logic_vector(6 downto 0); --address where data is written to
			data : in std_logic_vector(31 downto 0); --data
			wren : in std_logic; --write enable which allows data to be written to ram address
			q : out std_logic_vector(31 downto 0)
		); 
end RAM128_32;

--How this works: wren =1 then we write data to the ram at the address and write that same data out to q
--wren=0 then we read the data at the address without altering it and send it to q
 architecture behavioral of RAM128_32 is
	type ram_type is array (0 to 2**AddressWidth-1) of std_logic_vector(31 downto 0); --this makes a ram array that gets written data in write mode at an address
	signal ram : ram_type;
	signal data_reg : std_logic_vector(q'length-1 downto 0); --temporary placeholder for q within the process
	begin
	process(Clock)
	begin
		if rising_edge(Clock) then
			if wren='1' then
				ram(to_integer(unsigned(address))) <= data; --writes data to the memory space dictated by the address value which is converted to an indexing integer
				data_reg <= data; --writes the same data directly to the output because ram is a signal which wont be updated until process completion
			elsif wren = '0' then
				data_reg <= ram(to_integer(unsigned(address)));
			end if;
		end if;
	end process;
	q <= data_reg;
end behavioral;
