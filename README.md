# UART-Communication-Module-in-VHDL
This repository contains a VHDL implementation of a UART (Universal Asynchronous Receiver-Transmitter) communication module. The module consists of separate transmitter (uart_tx) and receiver (uart_rx) entities, designed to enable reliable serial communication between devices.
The UART communication module has been tested successfully on the FPGA Tang Nano 9K board. 

## Features

-Supports a configurable baud rate (default: 9600)

-Handles asynchronous transmission and reception of 8-bit data frames

-Uses a state machine-based design for robust data transfer

-Implements start, data, and stop bit generation/interpretation

-Provides signals for data transmission completion (done)


## File Structure

The repository is organized as follows:

-uart_rx.vhd: VHDL source file for the UART receiver entity.

-uart_tx.vhd: VHDL source file for the UART transmitter entity.

-top.vhd: VHDL source file contains the UART loopback module that can be used for testing. It provides the necessary connections between the transmitter and receiver modules to enable loopback functionality.


## Testing

The UART loopback  design serves as a test for data transfer between an FPGA and a PC. It enables bidirectional communication by automatically sending data back from the FPGA to the PC that was originally transmitted from the PC to the FPGA via UART. This loopback functionality facilitates the validation of data transmission and reception between the two devices.

RTL schematics:

![RTL](https://github.com/Saad-emb/UART-Communication-Module-in-VHDL/assets/123195068/0f1d59c9-3487-48d2-8fd2-9bcbd7f2b6ae)

Results:

![result](https://github.com/Saad-emb/UART-Communication-Module-in-VHDL/assets/123195068/edc2f8da-f591-447d-8279-573f398c58c1)





