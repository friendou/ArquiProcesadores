library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity ram_16bits is
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           direccion : in  STD_LOGIC_VECTOR (7 downto 0);
           doi : in  STD_LOGIC;
           rw : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  reset: in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (15 downto 0));
end ram_16bits;

architecture Behavioral of ram_16bits is

type ram is array (255 downto 0) of std_logic_vector(15 downto 0);
begin

process(clk, direccion, reset, doi, input, rw)
variable posicion: integer range 0 to 255; 
variable ram_memory: ram:= (others =>(others =>'0'));
begin
-----SUMA DE DOS NUMEROS---------------
--	ram_memory(0):="0001000000001001";
--	ram_memory(1):="0001000001000111";
--	ram_memory(2):="0110000000000000";
--	ram_memory(3):="1100111111000000";
--	ram_memory(4):="0101000000000000";
--	ram_memory(5):="1111111111111111";
-----------------------------------------
----MUTIPLICACION----------------------
	ram_memory(0):="0001100010000100";---RAM(130)<--2 --OPERANDO
	ram_memory(1):="0001100011000101";---RAM(131)<--3 --OPERANDO
	ram_memory(2):="0001100100000010";---RAM(132)<--2 --VARIABLE CONTROL
	ram_memory(3):="0001100110000001";---RAM(134)<--1 --AUXILIAR
	ram_memory(4):="0010000000100010";---RA<--RAM(130)
	ram_memory(5):="0010000001100010";---RB<--RAM(130)
	ram_memory(6):="0110000000000000";---RC<--RA+RB
	ram_memory(7):="0010111111100101";---RAM(133)<--RC --RESULTADO PARCIAL
	ram_memory(8):="0010000000100100";---RA<--RAM(132)
	ram_memory(9):="0010000001100011";---RB<--RAM(131)
	ram_memory(10):="0111000000000000";---COMPARE
	ram_memory(11):="0011000000000000";--JUMP IF EQUAL
	ram_memory(12):="1101000000010011";--BRANCH 16
	ram_memory(13):="0010000000100101";--RA<--RAM(133)
	ram_memory(14):="0010000001111110";--RB<--0
	ram_memory(15):="0110000000000000";---RC<--RA+RB
	ram_memory(16):="1100111111000000";--RAM(255)<--RC
	ram_memory(17):="0101000000000000";--OUT RAM(255)
	ram_memory(18):="1111111111111111";--HALT
	ram_memory(19):="0010000000100101";--RA<--RAM(133)
	ram_memory(20):="0010000001100010";--RB<--RAM(130)
	ram_memory(21):="0110000000000000";--RC<--RA+RB
	ram_memory(22):="0010111111100101";--RAM(133)<--RC
	ram_memory(23):="0010000000100100";--RA<--RAM(132)
	ram_memory(24):="0010000001100110";--RB<--RAM(134)
	ram_memory(25):="0110000000000000";--RC<--RA+RB
	ram_memory(26):="0010111111100100";--RAM(132)<--RC
	ram_memory(27):="1101000000001000";--BRANCH TO RAM(8)
---------------------------------------
-----TEST STR IN RAM-------------------
--	ram_memory(0):="0001111111000010";---RAM(130)<--2 --OPERANDO
--	ram_memory(1):="0001111100000011";---RAM(131)<--3 --OPERANDO
--	ram_memory(2):="0001111110000010";---RAM(132)<--2 --VARIABLE CONTROL
--	ram_memory(3):="0010000000111111";
--	ram_memory(4):="0010000001111100";
--	ram_memory(255):="1111111111111111";---RAM(134)<--1 --AUXILIAR
---------------------------------------
----TEST STORE IN RAM FROM REGISTERS---
--	ram_memory(0):="0001100010000010";---RAM(34)<--2 --OPERANDO
--	ram_memory(1):="0001100011000011";---RAM(35)<--3 --OPERANDO
--	ram_memory(2):="0001100100000010";---RAM(36)<--2 --VARIABLE CONTROL
--	ram_memory(3):="0001100110000001";---RAM(38)<--1 --AUXILIAR
--	ram_memory(4):="0010000000100010";---RA<--RAM(34)
--	ram_memory(5):="0010000001100011";---RB<--RAM(35)
--	ram_memory(6):="0110000000000000";---RC<--RA+RB
--	ram_memory(7):="0010111111111111";---RAM(63)<--RC --RESULTADO PARCIAL
--	ram_memory(8):="0010000000111111";
---------------------------------------
------TEST BRANCH----------------------
--	ram_memory(0):="0001000000000100";---RAM(130)<--2 --OPERANDO
--	ram_memory(1):="0001000001000110";---RAM(131)<--3 --OPERANDO
--	ram_memory(2):="1101000000000101";
--	ram_memory(3):="1111111111111111";---RAM(130)<--2 --OPERANDO
--	ram_memory(4):="1111111111111111";
--	ram_memory(5):="1101000000001000";
--	ram_memory(6):="1111111111111111";
--	ram_memory(7):="1111111111111111";
--	ram_memory(8):="1101000000000000";
---------------------------------------
	if(reset='1') then
				ram_memory := (others =>(others =>'0'));
	else
		if(clk='1') then
				posicion:= to_integer(unsigned(direccion));
				if(rw = '0') then
					--0 es read
					output<=ram_memory(posicion);
				else
					--if(doi = '1')	then
					--	if(posicion >127) then
							--1 es write
							ram_memory(posicion):=input;
					--	else
							--QUIERE ESCRIBIR EN INSTRUCCION EN MODO READ, PROHIBIR
					--	end if;
					--end if;
				end if;
		end if;
	end if;
end process;

end Behavioral;