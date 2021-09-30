#!/bin/bash

<<doc
g.sh - CMSC 132 GHDL helper

Usage:
./g.sh [OPTION]... [FILE]...

OPTIONS:
	d - delete the work object file (*.cf)
	a - analyze the files
	e - elaborate the test bench entity
	r - run the test bench entity
	v - visualize the simulation using a VCD file
	w - open the VCD file in GTKWave

EXAMPLES:
	To analyze the files (nand.vhd, inom.vhd, inom_tb.vhd):
	./g.sh a nand.vhd inom.vhd inom_tb.vhd
	
	To elaborate and run the test bench entity (assuming files have been analyzed prior):
	./g.sh er nand.vhd inom.vhd inom_tb.vhd
	
	To delete the .cf file, analyze, elaborate, and run the test bench entity:
	./g.sh daer nand.vhd inom.vhd inom_tb.vhd
	
	To analyze, elaborate, run, visualize, and open in GTKWave:
	./g.sh aervw nand.vhd inom.vhd inom_tb.vhd
	
NOTES:
	Files must be listed in the correct order.
	The test bench file should be the last argument.
	The entity to be tested should be the second to the last argument.
	Options are executed in order they are listed by the user.
doc

# colors
CYAN="\e[1;36m"
DEFAULT="\e[0m"

[[ $# -lt 2 ]] && echo $0: should have at least 2 arguments && exit

# test bench filename
tb=${@: -1}

# primary entity filename
pe=${@: -2:1}

# loop through every character option from $1
for (( i = 0; i < ${#1}; i++ )); do
	# delete work object
	if [[ ${1:$i:1} == "d" ]]; then
		echo -e "${CYAN}rm *.cf${DEFAULT}"
		rm *.cf
	fi
	# analyze
	if [[ ${1:$i:1} == "a" ]]; then
		for i in ${@:2}; do             # analyze all args from $2
			echo -e "${CYAN}ghdl -a $i.vhd${DEFAULT}"
			ghdl -a $i || exit
		done
	fi
	# elaborate
	if [[ ${1:$i:1} == "e" ]]; then
		echo -e "${CYAN}ghdl -e ${tb%.*}${DEFAULT}"
		ghdl -e ${tb%.*} || exit
	fi
	# run
	if [[ ${1:$i:1} == "r" ]]; then
		echo -e "${CYAN}ghdl -r ${tb%.*}${DEFAULT}"
		ghdl -r ${tb%.*} || exit
	fi
	# visualize
	if [[ ${1:$i:1} == "v" ]]; then
		echo -e "${CYAN}ghdl -r ${tb%.*} --vcd=${pe%.*}.vcd${DEFAULT}"
		ghdl -r ${tb%.*} --vcd=${pe%.*}.vcd || exit
	fi
	# open gtkwave
	if [[ ${1:$i:1} == "w" ]]; then
		echo -e "${CYAN}gtkwave ${pe%.*}.vcd${DEFAULT}"
		gtkwave ${pe%.*}.vcd || exit
	fi
done

