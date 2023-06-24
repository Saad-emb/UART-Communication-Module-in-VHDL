library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is port (
	
	clk : in std_logic;
    start : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
	data_tx : out std_logic);
end uart_tx;

architecture RTL of uart_tx is 

type mystates is (idle,start_bit, data, stop_bit);
signal present_state,next_state :mystates;

signal data_in_signal :STD_LOGIC_VECTOR (7 downto 0);
signal data_bit,data_bit_next :unsigned (4 downto 0);
signal data_tx_signal :std_logic;
signal done_signal : std_logic :='0';
signal clk_count, clk_count_next: POSITIVE;
CONSTANT CLKS_PER_BIT: NATURAL := 2812; --FREQUENCY / BAUD_RATE; In my case 27mhz/9600 


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
        clk_count_next <= 1;
        data_tx_signal<='1'; 
        done_signal<='0';
        if(start='1') then
        data_in_signal<=data_in;
        next_state<=start_bit;
        else
        next_state <= idle;
        end if;
        
    when start_bit=>
         if(clk_count = CLKS_PER_BIT+1) then
         next_state<=data;
         clk_count_next <= 1;
         
         else
         data_tx_signal<='0';
         clk_count_next<=clk_count+1;
         
end if;

    when data=>
         if(data_bit< "1000") then
            next_state<=data;
            if(clk_count < CLKS_PER_BIT+1) then
            data_tx_signal<=data_in_signal(to_integer(data_bit));
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
         data_tx_signal<='1';      
         clk_count_next<=clk_count+1;  
         end if;
end case;
end process;
data_tx<=data_tx_signal;



end RTL;