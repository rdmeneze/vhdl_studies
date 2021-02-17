-- Library
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity
ENTITY ALU IS
	PORT(
		Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
		A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 )
		);
END ALU;

-- Architecture
ARCHITECTURE ALU_ARCH OF ALU IS
	
	CONSTANT equal_A	:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "000";
	CONSTANT add_AB		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "001";
	CONSTANT sub_AB		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "010";
	CONSTANT and_AB		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "011";
	CONSTANT or_AB		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "100";
	CONSTANT inc_A		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "101";
	CONSTANT dec_A		:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "110";
	CONSTANT equal_B	:	STD_LOGIC_VECTOR( 2 DOWNTO 0 ) := "111";
	
BEGIN -- architecture
	comb_ALU: PROCESS(Op_code, A, B)
	BEGIN
		case (Op_code) is
			when equal_A =>		Y <= A;
			when add_AB =>		Y <= A + B;
			when sub_AB =>		Y <= A - B;
			when and_AB =>		Y <= A AND B;
			when or_AB =>		Y <= A OR B;
			when inc_A =>		Y <= STD_LOGIC_VECTOR(unsigned(A) - 1);
			when dec_A =>		Y <= STD_LOGIC_VECTOR(unsigned(A) - 1);
			when equal_B =>		Y <= B;
			when others =>		Y <= "00000000000000000000000000000000";
		end case;
	END PROCESS comb_ALU;
END ARCHITECTURE ALU_ARCH;