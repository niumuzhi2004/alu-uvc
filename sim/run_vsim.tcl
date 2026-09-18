## STEP 0: Clean Previous Simulation Data

file delete -force work
file delete -force coverage_report
file delete -force sim.log
file delete -force modelsim.ini

## STEP 1: Analyze Source Files

vlib work
vmap work work

# RTL files
exec vlog -sv -timescale 1ns/1ps ../rtl/alu_pkg.sv
exec vlog -sv -timescale 1ns/1ps ../rtl/alu.sv

# UVM files
exec vlog -sv -timescale 1ns/1ps -L uvm ../tb/alu_tb_pkg.sv
exec vlog -sv -timescale 1ns/1ps -L uvm ../tb/agent/alu_if.sv
exec vlog -sv -timescale 1ns/1ps -L uvm ../tb/top/tb_top.sv


## STEP 2: Run Simulation

exec vsim -c work.tb_top \
    -L uvm \
    +UVM_TESTNAME=alu_test \
    +UVM_VERBOSITY=UVM_LOW \
    -do "coverage save -onexit ucdb/tb_top.ucdb; run -all; quit -f" \
    -l sim.log

# generate coverage report
file mkdir ucdb
file mkdir coverage_report
exec vcover report ucdb/tb_top.ucdb -details -output coverage_report/coverage.txt

exit