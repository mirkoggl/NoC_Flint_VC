library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;

entity rr_arbiter is
	Port (
		Counter_In : in std_logic_vector(SEL_WIDTH - 1 downto 0);
		Valid_In   : in std_logic_vector(CHAN_NUMBER - 1 downto 0);
		Win_OneHot : out std_logic_vector(CHAN_NUMBER - 1 downto 0);
		Win_Out    : out std_logic_vector(SEL_WIDTH - 1 downto 0)
	);
end entity rr_arbiter;

architecture RTL of rr_arbiter is
	
	COMPONENT onehot_converter
		Port(
			vect_in  : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			vect_out : out std_logic_vector(SEL_WIDTH - 1 downto 0)
		);
	END COMPONENT;
	
	signal rr_temp, rr_choice, rr_winner : std_logic_vector(CHAN_NUMBER - 1 downto 0) := (others => '0');
	signal rr_counter :  std_logic_vector(SEL_WIDTH - 1 downto 0) := (others => '0');
	
begin
	
	rr_counter <= Counter_In;
	
	rr_temp   <= std_logic_vector(unsigned(Valid_In) rol CONV_INTEGER(rr_counter));
	rr_choice <= ((not rr_temp) + '1') and rr_temp;	
	rr_winner <= std_logic_vector(unsigned(rr_choice) ror CONV_INTEGER(rr_counter));
	Win_OneHot <= rr_winner;
	
	onehot_inst : onehot_converter
		Port Map(
			vect_in  => rr_winner,
			vect_out => Win_Out
		);

end architecture RTL;
