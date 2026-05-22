# ALU UVC - Universal Verification Component

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
- **NOT** - Bitwise complement of an operand
- **SHL** - Arithmetic left shift operation
- **SHR** - Arithmetic right shift operation

## Testbench Architecture
- **UVC** - agent (driver, monitor, and sequencer) and sequence item
- **Scoreboard** - checks result with reference model
- **Coverage** - functional covergroups for op, A, B, zero, cout, and opxzero cross coverage
- **Sequence** - 100 constrained random + 8 directed testing transactions

## Results
- 108 transactions per run
- 100% functional coverage achieved

## Requirements
| Tool | Version |
|---|---| 
| Xilinx Vivado | XSIM v2025.2 |
| UVM | UVM 1.2 (within Vivado) |

## How to Run
```cmd
cd sim
vivado -mode batch -source run.tcl
```

> Coverage report generated at `sim/coverage_report/functionalCoverageReport/xcrg_func_cov_report.txt`