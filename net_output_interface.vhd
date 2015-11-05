----------------------------------------------------------------------------------
-- Company: 
-- Author: 	Mirko Gagliardi
-- 
-- Create Date:    01/10/2015
-- Design Name: 
-- Module Name:    Network Output Interface - rtl 
-- Project Name:   Router_Mesh	
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 	 
--
-- Revision: v 0.4
-- Additional Comments:
--		Network Output Interface gestisce i dati in uscita dal Router su un dato canale. Ogni dato è bufferizzato in una FIFO circolare. 
--		Quando la FIFO non è vuota tenta di inviare il dato in testa all'Input Interface Network del Router con cui è collegato. L'invio del
--		avviene se l'Input interface del vicino è pronta a ricevere. Se il segnale di ready dal vicino è alto e la propria FIFO non è vuota, 
--		l'Output Interface asserisce valid ed incrementa la testa della FIFO. 
--
--			Output Interface				Input Interface
--			________________				__________________
--				       valid|-------------->|valid
--					Data_Out|-------------->|Data_In
--					  ready	|<--------------|ready
--							|				|
--											
--		Network Output Interface riceve i dati da inviare dalla Crossbar che collega tutti i FIFO Input Interface del router a tutti
--		i FIFO Output Interface. Quando il dato in ingresso è valido, la Control Unit asserisce wren. Se la FIFO non è piena, il dato
--		in ingresso è aggiunto in coda e sdone è asserito ad indicare che il salvataggio è stato effettuato correttamente. Se la Fifo è piena
--		full è alto e la Control Unit agirà di conseguenza.
--
--
--		    Output Interface				Control Unit
--			________________				_________________	
--					    wren|<--------------|wren
--						full|-------------->|full
--							|				|________________							
--							|					
--							|				Crossbar
--							|				_________________
--					 Data_In|<--------------|Data_Out
--							|				|
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;

entity net_output_interface is
	Generic (
		FIFO_LENGTH : natural := 16;
		DATA_WIDTH : natural := 16
	);
	Port (
		clk : in std_logic;
		reset : in std_logic;
		
		Data_In  : in std_logic_vector(DATA_WIDTH - 1 downto 0);   -- Data Input, from control unit
		Ready_In : in std_logic; 								   -- Ready signal, from neighbor Router Input interface	
		WrEn_In  : in std_logic;								   -- Write Enable, from control unit
		
		Full_Out  : out std_logic;								   -- Fifo Full, to the control unit
		Valid_Out : out std_logic;								   -- Data Output valid, to neighbor Router Input interface
		Data_Out  : out std_logic_vector(DATA_WIDTH - 1 downto 0)  -- Data Output, to neighbor Router Input interface
	);
end entity net_output_interface;

architecture RTL of net_output_interface is
	
	type fifo_type is array (0 to FIFO_LENGTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
		
	signal fifo_memory : fifo_type := (others => (others => '0'));
	signal head_pt, tail_pt : std_logic_vector(f_log2(FIFO_LENGTH)-1 downto 0) := (others => '0');	
	signal fifo_full, fifo_empty : std_logic := '0';
	
begin
	
	fifo_full <= '1' when head_pt = (tail_pt + '1')
						else '0';
	
	fifo_empty <= '1' when head_pt = tail_pt		
						else '0'; 
	
	Full_Out  <= fifo_full;
	Data_Out  <= fifo_memory(conv_integer(head_pt));
	Valid_Out <= '0' when head_pt = tail_pt		
						else '1'; 
	

	Output_Interface_Control_Unit : process (clk, reset)
	begin
		if reset = '1' then
		  head_pt <= (others => '0');
		  tail_pt <= (others => '0');
		  fifo_memory <= (others => (others => '0'));
		
		elsif rising_edge(clk) then		
		  		  
		  if WrEn_In = '1' and fifo_full = '0' then		-- Store data input
			   fifo_memory(conv_integer(tail_pt)) <= Data_In; 
			   tail_pt <= tail_pt + '1';
		  end if;
			   
		  if fifo_empty = '0' and Ready_In = '1' then	-- Send Fifo first element
			   head_pt <= head_pt + '1';
		  end if;
			    
		
		end if;
	end process;

end architecture RTL;