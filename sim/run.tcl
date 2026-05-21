## STEP 1: Analyze Source Files

# RTL files
exec xvlog -sv ../rtl/alu_pkg.sv
exec xvlog -sv ../rtl/alu.sv

# UVM files
exec xvlog -sv -L uvm ../tb/alu_tb_pkg.sv
exec xvlog -sv -L uvm ../tb/top/tb_top.sv


## STEP 2: Elaborate Design

exec xelab -top tb_top -snapshot tb_top_snapshot \
    -L uvm \
    -timescale 1ns/1ps \
    -debug typical


## STEP 3: Run Simulation

exec xsim tb_top_snapshot \
    -testplusarg UVM_TESTNAME=alu_test \
    -testplusarg UVM_VERBOSITY=UVM_LOW \
    -runall \
    -log sim.log

# generate coverage report
exec xcrg -report_format text -dir xsim.covdb/tb_top_snapshot -report_dir coverage_report

exit