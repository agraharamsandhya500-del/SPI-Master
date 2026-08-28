# SPI Master in Verilog

## 📌 Project Overview

This project implements an **SPI (Serial Peripheral Interface) Master** using Verilog HDL.

The SPI Master transmits an 8-bit data word serially through the MOSI line while generating the SPI clock and chip-select signals.

## 🔧 Features

* 8-bit SPI data transmission
* MOSI output
* SCLK generation
* Chip Select (CS) control
* Busy status signal
* Transfer Done signal
* Synchronous digital design
* Parameterized clock divider
* Verilog testbench included

## 📁 Project Files

```text
SPI-Master-Verilog/
│
├── spi_master.v
├── spi_master_tb.v
└── README.md
```

## 🔌 SPI Signals

| Signal          | Description                      |
| --------------- | -------------------------------- |
| `clk`           | System clock                     |
| `rst`           | Reset                            |
| `start`         | Starts SPI transmission          |
| `data_in[7:0]`  | 8-bit parallel input data        |
| `sclk`          | SPI serial clock                 |
| `mosi`          | Master Out Slave In              |
| `cs`            | Chip Select                      |
| `data_out[7:0]` | Transmitted data                 |
| `busy`          | Indicates active transmission    |
| `done`          | Indicates completed transmission |

## ⚙️ Working Principle

1. Reset initializes the SPI Master.
2. The `start` signal begins a transmission.
3. The input 8-bit data is loaded into the shift register.
4. The MSB is placed on the MOSI line.
5. The SPI clock `SCLK` is generated.
6. Data is shifted out one bit at a time.
7. After 8 bits are transmitted, `done` becomes HIGH.
8. `CS` returns HIGH and `busy` becomes LOW.

## 🧪 Simulation

Test data:

```text
10101010
```

Expected result:

```text
Data Sent    = 10101010
Data Output  = 10101010
CS           = 1
BUSY         = 0
DONE         = 1
```

## 🛠️ Tools

This project can be simulated using:

* Icarus Verilog
* GTKWave
* ModelSim
* Vivado

## ▶️ Run Using Icarus Verilog

Compile:

```bash
iverilog -o spi_sim spi_master.v spi_master_tb.v
```

Run:

```bash
vvp spi_sim
```

For waveform generation, add `$dumpfile` and `$dumpvars` to the testbench and run:

```bash
vvp spi_sim
```

Then open the waveform with GTKWave.

## 🎯 Applications

* Sensor communication
* Flash memory interface
* ADC/DAC communication
* Microcontroller peripherals
* FPGA communication systems
* Embedded systems

## 📚 Conclusion

The SPI Master demonstrates how serial data communication can be implemented using Verilog HDL. It generates the SPI clock, controls chip select, and serially transmits an 8-bit data word through MOSI.
