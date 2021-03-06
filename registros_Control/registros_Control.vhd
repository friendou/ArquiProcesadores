library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity registros_Control is
    Port ( input_From_Ram : in  STD_LOGIC_VECTOR (15 downto 0);
			  input_increase_PC: in STD_LOGIC_VECTOR(1 downto 0);
			  input_PC_Branch: in STD_LOGIC_VECTOR(7 downto 0);
			  enable_Write_PC: in STD_LOGIC;
			  clk: in STD_LOGIC;
			  reset : in STD_LOGIC;
           direccion_RAM : out  STD_LOGIC_VECTOR (7 downto 0);
           CU : out  STD_LOGIC_VECTOR (15 downto 0));
end registros_Control;

architecture Behavioral of registros_Control is	

	
	COMPONENT registro_8bits
	PORT(
		input : IN std_logic_vector(7 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;
		rw : IN std_logic;          
		output : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registro_16bits
	PORT(
		input : IN std_logic_vector(15 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;
		rw : IN std_logic;          
		output : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registros_Clk
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		increase_PC : IN std_logic_vector(1 downto 0);
		enable_Change_PC : IN std_logic;
		change_PC : IN std_logic_vector(7 downto 0);          
		input_PC : OUT std_logic_vector(7 downto 0);
		clk_PC : OUT std_logic;
		clk_MAR : OUT std_logic;
		clk_MBR : OUT std_logic;
		clk_IR : OUT std_logic;
		rw_PC : OUT std_logic;
		rw_MAR : OUT std_logic;
		rw_MBR : OUT std_logic;
		rw_IR : OUT std_logic
		);
	END COMPONENT;
	
signal input_PC, input_MAR, output_Demux: std_logic_vector(7 downto 0):="00000000";
signal input_IR: std_logic_vector(15 downto 0):="0000000000000000";
signal clk_PC, clk_MAR, clk_MBR, clk_IR: std_logic:='0';
signal rw_PC, rw_MAR, rw_MBR, rw_IR: std_logic:='0';


begin

	Inst_registros_Clk: registros_Clk PORT MAP(
		clk => clk,
		reset => reset,
		increase_PC => input_increase_PC,
		enable_Change_PC => enable_Write_PC,
		change_PC => input_PC_Branch,
		input_PC => input_PC,
		clk_PC => clk_PC,
		clk_MAR => clk_MAR,
		clk_MBR => clk_MBR,
		clk_IR => clk_IR,
		rw_PC => rw_PC,
		rw_MAR => rw_MAR,
		rw_MBR => rw_MBR,
		rw_IR => rw_IR
	);
	
	PC: registro_8bits PORT MAP(
		input => input_PC,
		reset => reset,
		clk => clk_PC,
		rw => rw_PC,
		output => input_MAR
	);
	
	MAR: registro_8bits PORT MAP(
		input => input_MAR,
		reset => reset,
		clk => clk_MAR,
		rw => rw_MAR,
		output => direccion_RAM
	);
		
	MBR: registro_16bits PORT MAP(
		input => input_From_Ram,
		reset => reset,
		clk => clk_MBR,
		rw => rw_MBR,
		output => input_IR
	);
	
	IR: registro_16bits PORT MAP(
		input => input_IR,
		reset => reset,
		clk => clk_IR,
		rw => rw_IR,
		output => CU
	);

end Behavioral;

