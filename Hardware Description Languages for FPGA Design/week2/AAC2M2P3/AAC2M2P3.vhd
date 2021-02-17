LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.numeric_bit_unsigned.all;
USE ieee.std_logic_textio.all;
USE std.textio.all;
USE work.all;
USE IEEE.std_logic_unsigned.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture AAC2M2P3 of FSM is
signal State: std_logic_vector(1 downto 0);

begin starte_Machine : process(CLK, RST)
begin
	if (RST = '1') then 
		State <= "00";
		Out1 <= '0';
	end if;
	if (State = "10") then 
		Out1 <= '1';
	else 
		Out1 <= '0';
	end if;
	if (rising_edge(CLK)) then
		case State is
			when "00" =>	--A
				if (In1 = '1') then
					State <= "01";
				else
					State <= "00";
				end if;
			when "01" =>	--B
				if (In1 = '1') then
					State <= "01";
				else
					State <= "10";
				end if;
			when "10" =>	--C
				if (In1 = '1') then
					State <= "00";
				else
					State <= "10";
				end if;
			when others =>	--D
				State <= "00";
		end case;			
	end if;
end process;
end architecture;