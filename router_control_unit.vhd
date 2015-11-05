----------------------------------------------------------------------------------
-- Company: 
-- Author: 	Mirko Gagliardi
-- 
-- Create Date:    01/10/2015
-- Design Name: 
-- Module Name:    Control Unit - rtl 
-- Project Name:   Router_Mesh	
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 	 
--
-- Revision: v 0.2
-- Additional Comments:
--		La Control Unit uno sceglie tra i FIFO Input Interface il cui empty è basso (ad indicare che hanno almeno un 
--		elemento nella coda). La scelta è effettuata mediante un arbitro RR (componente rr_arbiter), il vincitore è 
--		schedulato per l'invio. 
--		La CU controlla la destinazione del pacchetto in testa alla coda del vincitore. Il componente routing_logic_xy
--		controlla la destinazione del pacchetto (usa il DOR) e calcola su quale interfaccia di uscita deve essere smistato.
--		Tale componente restituisce anche il segnale di selezione da passare alla crossbar per collegare la FIFO input 
--      interface e la FIFO output interface interessati. 
--		La CU asserisce il write enable della FIFO output interessata in modo da predisporla alla ricezione del dato.
--		Se l'interfaccia di uscita ha la coda piena, il pacchetto viene perso.
--		
--		Input Interface	             Control Unit   		              Output Interface
--		_______________	       ______________________                __________________
--			  Data_Out|------->|Data_II       Full_OI|<--------------|full
--				 empty|------->|Empty_II     Wr_En_OI|-------------->|wren
--				  shft|<-------|Shft_II         ready|<--------------|ready
--					  |  	   |                     |               |
--													 |
--													 |
--		                          					 |   		Crossbar
--													 |		_________________	
--											Cross_Sel|----->|cross_sel
--													 |		|									
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

entity router_control_unit is
	Generic (
		LOCAL_X : natural := 1;
		LOCAL_Y : natural := 1
	);
	Port (
		clk   : in std_logic;
		reset : in std_logic;
		
		Data_II  : in data_array_type;							  -- Data input from all the Input Interfaces
		Empty_II : in std_logic_vector(CHAN_NUMBER-1 downto 0);	  -- Empty FIFO control signal from all the Input Interfaces
		Full_OI  : in std_logic_vector(CHAN_NUMBER-1 downto 0);   -- Full FIFO control signal from all the Output Interfaces
		
		Shft_II   : out std_logic_vector(CHAN_NUMBER-1 downto 0); -- Shift enable signal to Input Interfaces
		Wr_En_OI  : out std_logic_vector(CHAN_NUMBER-1 downto 0); -- Write enable signal to Output Interfaces
		Cross_Sel : out crossbar_sel_type						  -- Crossbar sel control signal	
	);
end entity router_control_unit;

architecture RTL of router_control_unit is
		
	COMPONENT routing_logic_xy
		Generic(
			LOCAL_X    : natural := 1;
			LOCAL_Y    : natural := 1
		);
		Port(
			Data_In      : in std_logic_vector(DATA_WIDTH-1 downto 0);
			In_Channel   : in std_logic_vector(SEL_WIDTH-1 downto 0);
			Out_Channel  : out std_logic_vector(SEL_WIDTH-1 downto 0); 
			Crossbar_Sel : out crossbar_sel_type		
		);
	END COMPONENT routing_logic_xy;
	
	COMPONENT rr_arbiter
		Port(
			Counter_In : in std_logic_vector(SEL_WIDTH - 1 downto 0);
			Valid_In   : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Win_Out    : out std_logic_vector(SEL_WIDTH - 1 downto 0)
		);
	END COMPONENT;
	
	constant ONE_VECT : std_logic_vector(CHAN_NUMBER - 1 downto 0) := (others => '1');
	type state_type is (out_wren, out_delay); 
	
	-- Control Unit Signals
	signal current_s : state_type := out_wren;
	signal n_empty_in  : std_logic_vector(CHAN_NUMBER - 1 downto 0) := (others => '0');
	signal rr_counter  : std_logic_vector(SEL_WIDTH - 1 downto 0) := (others => '0');
	signal rr_index    : std_logic_vector(SEL_WIDTH - 1 downto 0)  := (others => '0');
	signal xy_data_in  : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
	signal xy_chan_in  : std_logic_vector(SEL_WIDTH - 1 downto 0) := (others => '0');
	signal xy_chan_out : std_logic_vector(SEL_WIDTH - 1 downto 0) := (others => '0');
	
begin

  -----------------------------------------------------------------------
  -- Round Robin Arbiter
  -----------------------------------------------------------------------
	
	n_empty_in <= not Empty_II;
	
	rr_arb_inst : rr_arbiter
		Port Map(
			Counter_In => rr_counter,
			Valid_In => n_empty_in,
			Win_Out  => rr_index
		);

  -----------------------------------------------------------------------
  -- DOR Routing Logic
  -----------------------------------------------------------------------
  	
	XY_logic : routing_logic_xy
		Generic Map(
			LOCAL_X    => LOCAL_X,
			LOCAL_Y    => LOCAL_Y
		)
		Port Map(
			Data_In      => xy_data_in,
			In_Channel   => xy_chan_in,
			Out_Channel  => xy_chan_out,
			Crossbar_Sel => Cross_Sel
		);
	
	xy_data_in <= Data_II(CONV_INTEGER(rr_index)) when Empty_II /= ONE_VECT; 
	xy_chan_in <= rr_index when Empty_II /= ONE_VECT; 	
	
	CU_process : process (clk, reset)
	begin
		if reset = '1' then
			current_s <= out_wren;
			Wr_En_OI <= (others => '0');
			Shft_II <= (others => '0');
			rr_counter <= (others => '0');
		
		elsif rising_edge(clk) then		
			
			Shft_II <= (others => '0');
			Wr_En_OI <= (others => '0');
			
			if rr_counter = CONV_STD_LOGIC_VECTOR(CHAN_NUMBER-1, SEL_WIDTH) then
				rr_counter <= (others => '0');
			else
				rr_counter <= rr_counter + '1';
			end if;
					
			case current_s is

			when out_wren =>
			 if Empty_II /= ONE_VECT then	
				if Full_OI(CONV_INTEGER(xy_chan_out)) = '1' then  -- FIFO Out full, scarta il pacchetto e torna idle
					current_s <= out_wren;
				else
					current_s <= out_delay;
					Wr_En_OI(CONV_INTEGER(xy_chan_out)) <= '1';
					Shft_II(CONV_INTEGER(xy_chan_in)) <= '1';
				end if;
			 end if;
			
			when out_delay => 	-- Stato usato per generare impulsi di write ed evitare di scrivere nel buffer di uscita più volte lo stesso dato
				current_s <= out_wren;
						    
			end case;
		
		end if;
	end process;
	
end architecture RTL;
