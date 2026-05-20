## STEP 1: Analyze Source Files

# RTL files
xvlog -sv ../rtl/alu_pkg.sv
xvlog -sv ../rtl/alu.sv

# UVM files
xvlog -sv -L uvm ../agent/alu_if.sv
xvlog -sv -L uvm ../agent/alu_sequencer.sv
xvlog -sv -L uvm ../agent/alu_driver.sv
xvlog -sv -L uvm ../agent/alu_monitor.sv
xvlog -sv -L uvm ../agent/alu_agent.sv

xvlog -sv -L uvm ../env/alu_env.sv
xvlog -sv -L uvm ../env/alu_coverage.sv
xvlog -sv -L uvm ../env/alu_scoreboard.sv

xvlog -sv -L uvm ../sequence/alu_base_seq.sv
xvlog -sv -L uvm ../test/alu_test.sv
xvlog -sv -L uvm ../top/tb_top.sv


## STEP 2: Elaborate Design

xelab -top tb_top -snapshot tb_top_snapshot \
    -L uvm \
    -timescale 1ns/1ps \
    -debug typical


## STEP 3: Run Simulation

xsim tb_top_snapshot \
    -testplusarg UVM_TESTNAME=alu_test \
    -testplusarg UVM_VERBOSITY=UVM_LOW \
    -runall \
    -log sim.log

exit