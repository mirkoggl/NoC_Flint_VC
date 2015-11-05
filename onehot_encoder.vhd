library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.logpack.all;
use work.routerpack.all;

entity onehot_encoder is
	Port(
		vect_in  : in std_logic_vector(SEL_WIDTH-1 downto 0);
		vect_out : out std_logic_vector(CHAN_NUMBER-1 downto 0)
	);
end entity onehot_encoder;

architecture RTL of onehot_encoder is
	
begin
	
 onehot : process (vect_in) begin	
	case vect_in is
	  when "000" =>   vect_out <= "00001";
	  when "001" =>   vect_out <= "00010";
	  when "010" =>   vect_out <= "00100";
	  when "011" =>   vect_out <= "01000";
	  when "100" =>	vect_out <= "10000";
	  when others => vect_out <= "00000";
	end case;
 end process;

end architecture RTL;