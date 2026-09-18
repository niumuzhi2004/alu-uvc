# ALU UVM Verification Component

## Overview
This project implements a simple **UVM (Universal Verification Methodology) verification component** for an 8-bit Arithmetic Logic Unit (ALU).

## DUT Specification
The ALU UVC tests and validates an 8-bit ALU with the following specifications:
| Signal | Direction | Bit Width | Specification |
|---|---|---|---|
| **A** | Input | 8 | First operand |
| **B** | Input | 8 | Second operand |
| **op** | Input | 3 | Operation code |
| **result** | Output | 8 | Calculation result |
| **zero** | Output | 1 | Zero flag: 1 if result is zero |
| **cout** | Output | 1 | Carry out |

It supports the following operations:

- **ADD** - Arithmetic addition of two 8-bit operands
- **SUB** - Arithmetic subtraction of two 8-bit operands
- **AND** - Logical AND operation between two operands
- **OR** - Logical OR operation between two operands
- **XOR** - Logical XOR operation between two operands
- **NAND** - Logical NAND operation between two operands
- **NOR** - Logical NOR operation between two operands
- **SLT** - Set on Less Than: result LSB is 1 if A < B, else 0

## Testbench Architecture
- **UVC** - agent (driver, monitor, and sequencer) and sequence item
- **Scoreboard** - checks result with reference model
- **Coverage** - functional covergroups for op, A, B, zero, cout, and opxzero cross coverage
- **Sequence** - 200 constrained random + 8 directed testing transactions

## Results
- 208 transactions per run
- 100% functional coverage achieved

## Requirements
Any of the following tools is supported:
| Tool | Version |
|---|---| 
| Xilinx Vivado | xsim v2025.2 (UVM 1.2) | 
| QuestaSim | vsim v10.4c (UVM 1.1d) |

## How to Run
For Vivado: 
```cmd
cd sim
vivado -mode batch -source run_xsim.tcl
```

For QuestaSim:
```cmd
cd sim
vsim -c -do run_vsim.tcl
```

> Coverage report generated at `sim/coverage_report/`