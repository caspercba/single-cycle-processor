
#
# Taken base config from: https://github.com/wwerst/EE119b_AVR 	
#


STACK_SIZE = $(shell ulimit -s)
WORK_DIR=work
GHDL_FLAGS=--std=08 --workdir=$(WORK_DIR)
GHDL_CMD=ghdl
GTKWAVE=gtkwave

#.PHONY: all lst2test cpu_test_vector_files import alu_tests iau_tests dau_tests reg_tests
.PHONY: all alu_tests

#.PHONY: cpu_tests_all cpu_alu_tests cpu_data_move_tests cpu_flow_skip_tests cpu_flow_cond_branch_tests

#.PHONY: cpu_flow_uncond_branch_tests continuous_tests clean

tests: signext_tests flopr_tests alu_tests imem_tests regfile_tests maindec_tests mux_tests fetch_tests execute_tests

all:
	sleep 1

import: clean
	mkdir -p work
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/shared/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/alu/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/flopr/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/signext/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/imem/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/regfile/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/maindec/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/mux/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/fetch/*.vhd
	@$(GHDL_CMD) -i $(GHDL_FLAGS) src/execute/*.vhd

execute_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) execute_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) execute_tb --vcd=$(WORK_DIR)/execute_tb.vcd --wave=execute_tb.ghw --stop-time=950ns
	#@$(GTKWAVE) execute_tb.ghw 

fetch_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) fetch_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) fetch_tb --vcd=$(WORK_DIR)/fetch_tb.vcd --wave=fetch_tb.ghw --stop-time=950ns
	#@$(GTKWAVE) fetch_tb.ghw 

mux_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) mux_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) mux_tb --vcd=$(WORK_DIR)/mux_tb.vcd --wave=mux_tb.ghw --stop-time=950ns
	@$(GTKWAVE) mux_tb.ghw 

maindec_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) maindec_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) maindec_tb --vcd=$(WORK_DIR)/maindec_tb.vcd --wave=maindec_tb.ghw --stop-time=950ns
	@$(GTKWAVE) maindec_tb.ghw 
	
regfile_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) regfile_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) regfile_tb --vcd=$(WORK_DIR)/regfile_tb.vcd --wave=regfile_tb.ghw --stop-time=950ns
	@$(GTKWAVE) regfile_tb.ghw 

imem_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) imem_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) imem_tb --vcd=$(WORK_DIR)/imem_tb.vcd --wave=imem_tb.ghw 
	@$(GTKWAVE) imem_tb.ghw 

alu_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) alu_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) alu_tb --vcd=$(WORK_DIR)/alu_tb.vcd --wave=alu_tb.ghw
	@$(GTKWAVE) alu_tb.ghw 

flopr_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) flopr_tb
	@$(GHDL_CMD) -r $(GHDL_FLAGS) flopr_tb --vcd=$(WORK_DIR)/flopr_tb.vcd --wave=flopr_tb.ghw --stop-time=150ns
	@$(GTKWAVE) flopr_tb.ghw --end=150000000

signext_tests: import
	@$(GHDL_CMD) -m $(GHDL_FLAGS) signext_tb 
	@$(GHDL_CMD) -r $(GHDL_FLAGS) signext_tb --vcd=$(WORK_DIR)/signext_tb.vcd --wave=signext_tb.ghw --stop-time=150ns
	@$(GTKWAVE) signext_tb.ghw --end=150000000

#iau_tests: import
#	ghdl -m --std=08 --workdir=work iau_tb
#	ghdl -r --std=08 --workdir=work iau_tb --vcd=avr_iau_tb.vcd

#dau_tests: import
#	ghdl -m --std=08 --workdir=work dau_tb
#	ghdl -r --std=08 --workdir=work dau_tb --vcd=avr_dau_tb.vcd

#reg_tests: import
#	ghdl -m --std=08 --workdir=work avr_reg_tb
#	ghdl -r --std=08 --workdir=work avr_reg_tb --max-stack-alloc=$(STACK_SIZE) --vcd=avr_reg_tb.vcd

#cpu_tests_all: cpu_fullprogram_tests
#	sleep 1

#cpu_fullprogram_tests: import
#	ghdl -m --ieee=synopsys --std=08 --workdir=work cpu_programfull_tb 
#	ghdl -r --ieee=synopsys --std=08 --workdir=work cpu_programfull_tb  --ieee-asserts=disable --wave=fullprogram_tb.ghw --vcd=fullprogram_tb.vcd

#continuous_tests:
#	fswatch -m poll_monitor -0 -o src/* | xargs -0 -n1 bash -c "clear && echo '*****************Running Tests***************************' && make cpu_fullprogram_tests"

clean:
	rm -r work/*.cf || true
	rm *.vcd        || true
	rm *.ghw        || true
