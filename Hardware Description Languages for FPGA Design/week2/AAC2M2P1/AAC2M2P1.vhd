LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
    CP:     in std_logic;   -- clock
    SR:     in std_logic;   -- Active low, synchronous reset
    P:      in std_logic_vector(3 downto 0);  -- Parallel input
    PE:     in std_logic;   -- Parallel Enable (Load)
    CEP:    in std_logic;   -- Count enable parallel input
    CET:    in std_logic;   -- Count enable trickle input
    Q:      out std_logic_vector(3 downto 0);            			
    TC:     out std_logic   -- Terminal Count
);            		
end AAC2M2P1;

architecture rtl of AAC2M2P1 is
    variable counter : integer range 0 to 15;
begin
    proc_name: process(CP, SR)
    begin
        if rising_edge( CP ) then
            if falling_edge( SR ) then
                counter := 0;
            end if;

            if falling_edge( PE ) then 
                counter := P;
            end if;

        end if;
    end process proc_name;
    
    
end architecture rtl;