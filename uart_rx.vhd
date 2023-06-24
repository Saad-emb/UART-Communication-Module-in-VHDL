
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is port (
	
	clk : in std_logic;
    data_in: in std_logic;
    data_tx : out std_logic_vector(7 downto 0);
    done: out std_logic);
end uart_rx;

architecture RTL of uart_rx is 

type mystates is (idle,start_bit, data, stop_bit);
signal present_state,next_state :mystates;

signal data_bit,data_bit_next :unsigned (4 downto 0);
signal data_tx_signal :std_logic_vector(7 downto 0);
signal done_signal : std_logic :='0';
signal clk_count, clk_count_next: POSITIVE;
CONSTANT CLKS_PER_BIT: NATURAL := 2812; --FREQUENCY / BAUD_RATE;


begin 

process(clk)
begin
	
if(rising_edge(clk)) then 
      present_state<=next_state;
      clk_count <= clk_count_next;
      data_bit<=data_bit_next;
	end if;

end process;

process(clk,present_state)
begin
    next_state<=present_state;
    clk_count_next <= clk_count;
    data_bit_next<= data_bit;
case (present_state) is
    when idle=>
        data_bit_next <= (others => '0');
        if (data_in = '1') then
            next_state<=idle;
            done_signal<='0';
        else
            next_state<=start_bit;
            done_signal<='0';
        end if;
        
        
  
    when start_bit=>

        if(clk_count = CLKS_PER_BIT+1) then
            next_state<=data;
            clk_count_next <= 1;
        else
            clk_count_next<=clk_count+1;         
end if;

    when data=>
         if(data_bit< "1000") then
            next_state<=data;
            if(clk_count < CLKS_PER_BIT+1) then
            data_tx_signal(to_integer(data_bit))<=data_in;
            clk_count_next<=clk_count+1;
            elsif (clk_count = CLKS_PER_BIT+1) then
            data_bit_next<=data_bit+1;
            clk_count_next <= 1; 
             end if;
        else
            next_state<=stop_bit;      
        end if;

    when stop_bit=>
        if(clk_count = CLKS_PER_BIT+1) then
         next_state<=idle;
         clk_count_next <= 1;
         done_signal<='1';
         else     
         clk_count_next<=clk_count+1; 
         end if;
end case;
end process;
data_tx<=data_tx_signal;
done<=done_signal;




end RTL;