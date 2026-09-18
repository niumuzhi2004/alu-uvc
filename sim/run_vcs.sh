set -e

## STEP 1: Analyze Source Files & Elaborate Design

vcs -full64 -sverilog \
    -ntb_opts uvm \
    -timescale=1ns/1ps \
    -debug_access+all \
    +incdir+../tb \
    ../rtl/alu_pkg.sv \
    ../rtl/alu.sv \
    ../tb/alu_tb_pkg.sv \
    ../tb/agent/alu_if.sv \
    ../tb/top/tb_top.sv \
    -l compile.log

## STEP 2: Run Simulation

./simv +UVM_TESTNAME=alu_test \
    +UVM_VERBOSITY=UVM_LOW \
    -l sim.log

# generate coverage report
urg -dir simv.vdb -format text -report coverage_report
