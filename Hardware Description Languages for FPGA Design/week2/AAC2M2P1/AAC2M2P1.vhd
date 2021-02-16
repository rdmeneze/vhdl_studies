--LIBRARY ieee;
--USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;


LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
use IEEE.std_logic_unsigned.all; 

entity AAC2M2P1 is port (                 	 
   CP: 	in std_logic; 	-- clock 
   SR:  in std_logic;  -- Active low, synchronous reset 
   P:    in std_logic_vector(3 downto 0);  -- Parallel input 
   PE:   in std_logic;  -- Parallel Enable (Load) 
   CEP: in std_logic;  -- Count enable parallel input 
   CET:  in std_logic; -- Count enable trickle input 
   Q:   out std_logic_vector(3 downto 0);            			 
   TC:  out std_logic  -- Terminal Count 
);            		 

end AAC2M2P1; 

architecture LS163 of AAC2M2P1 is  
    signal temp: std_logic_vector(3 downto 0); 
begin 
    process(CP,CET,CEP) begin 
        if (rising_edge(CP) and SR = '0') then 
            temp <= "0000"; 
        elsif (rising_edge(CP)) then 
            if (PE = '0') then 
                temp <= P; 
            elsif(CET = '1' and CEP = '1') then  
                temp <= temp + 1; 
            end if; 
        end if; 
    end process; 
    Q <= temp; 
    TC <= temp(0) and temp(1) and temp(2) and temp(3) and not(CET); 
end LS163;
 
-- architecture s74lLS63 of AAC2M2P1 is
-- begin
--     proc_name: process(CP, SR)
--         variable counter : integer range 0 to 16;
--     begin
--         if rising_edge( CP ) then

--             if (counter = 15) then
--                 TC <= '1';
--             else
--                 TC <= '0';
--             end if;

--             if ( (CET and CEP) = '1' ) then
-- 		if (counter < 16 ) then
--                   counter := counter + 1;
-- 	        else
-- 		  counter := 0;
--                 end if;
-- 	    end if;

--             if falling_edge( SR ) then
--                 counter := 0;
--             elsif falling_edge( PE ) then 
--                 counter := to_integer( unsigned( P ));
--             end if;

--         end if;

-- 	Q <= std_logic_vector( to_unsigned( counter, Q'length ) );

--     end process proc_name;   
    
-- end architecture s74lLS63;