library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is port (

	clk : in std_logic;
    data_rx : in std_logic;
    data_out : out std_logic
    
);
end top;

architecture RTL of top is 

signal data_in_signal : std_logic_vector(7 downto 0);
signal start_tx_signal :std_logic;

component uart_tx is
port(
	clk : in std_logic;
    start : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
	data_tx : out std_logic);
end component;

component uart_rx is

    port (
  	clk : in std_logic;
    data_in: in std_logic;
    data_tx : out std_logic_vector(7 downto 0);
    done: out std_logic);
end component;

begin
u0: uart_tx port map(
clk=>clk,
start=>start_tx_signal,
data_in=>data_in_signal,
data_tx=>data_out);

u1: uart_rx port map(
clk=>clk,
data_in=>data_rx,
data_tx=>data_in_signal,
done=>start_tx_signal);

end RTL;