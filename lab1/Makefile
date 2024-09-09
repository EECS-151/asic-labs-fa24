SHELL                   := $(shell which bash) -o pipefail
ABS_TOP                 := $(shell pwd)

SIM_RTL                 := $(shell find $(ABS_TOP)/sim -type f -name "*.v")
SIM_TARGETS             := $(shell realpath --relative-to $(ABS_TOP) $(SIM_RTL))

VCS                     := /home/ff/eecs151/hammer-tools/synopsys/vcs/P-2019.06/bin/vcs -full64
VCS_OPTS                := -notice -line +lint=all,noVCDE,noNS,noSVA-UA -sverilog -timescale=1ns/1ps -debug
VCS_TARGETS             := $(SIM_TARGETS:%.v=%.vpd)
IVERILOG                := iverilog
IVERILOG_OPTS           := -D IVERILOG=1 -g2012 -gassertions -Wall -Wno-timescale
IVERILOG_TARGETS        := $(SIM_TARGETS:%.v=%.fst)
VVP                     := vvp
RTL						:= $(ABS_TOP)/src/d_flip_flop.v

.PHONY: FORCE

sim/%.tb: sim/%.v FORCE
	cd sim && $(VCS) $(VCS_OPTS) -o $*.tb $*.v $(RTL) ../src/$(patsubst %_tb.v,%.v,$(notdir $<))

# special case where one tb depends on two sources
sim/decoder_4_to_16_tb.tb: sim/decoder_4_to_16_tb.v FORCE
	cd sim && $(VCS) $(VCS_OPTS) -o decoder_4_to_16_tb.tb decoder_4_to_16_tb.v $(RTL) ../src/line_decoder.v ../src/$(patsubst %_tb.v,%.v,$(notdir $<))

$(VCS_TARGETS): sim/%.vpd: sim/%.tb FORCE
	cd sim && ./$*.tb +verbose=1 +vpdfile+$*.vpd

sim-all: 
	make sim/one_bit_comparator_structural_tb.vpd 
	make sim/one_bit_comparator_behavioral_tb.vpd 
	make sim/one_bit_comparator_always_tb.vpd 
	make sim/four_bit_comparator_always_tb.vpd 
	make sim/shift_register_structural_tb.vpd 
	make sim/shift_register_behavioral_tb.vpd 
	make sim/simple_counter_tb.vpd 
	make sim/decoder_4_to_16_tb.vpd

clean: FORCE
	rm -rf ./build $(junk) *.daidir sim/output.txt \
	sim/*.tb sim/*.daidir sim/csrc \
	sim/ucli.key sim/*.vpd sim/*.vcd \
	sim/*.tbi sim/*.fst sim/*.jou sim/*.log sim/*.out
	