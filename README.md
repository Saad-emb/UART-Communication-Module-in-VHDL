# UART-Communication-Module-in-VHDL
This repository contains a VHDL implementation of a UART (Universal Asynchronous Receiver-Transmitter) communication module. The module consists of separate transmitter (uart_tx) and receiver (uart_rx) entities, designed to enable reliable serial communication between devices.

## Features

-Supports a configurable baud rate (default: 9600)
-Handles asynchronous transmission and reception of 8-bit data frames
-Uses a state machine-based design for robust data transfer
-Implements start, data, and stop bit generation/interpretation
-Provides signals for data transmission completion (done)

The code is provided as synthesizable VHDL, making it suitable for FPGA or ASIC implementations. Testbenches and simulation files are included to verify the functionality of the modules.


