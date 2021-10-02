# `g.sh` - CMSC 132 GHDL helper

## Usage:
```
./g.sh [OPTION]... [FILE]...
```

## Options:
- `d` - delete the work object file (*.cf)
- `a` - analyze the files
- `e` - elaborate the test bench entity
- `r` - run the test bench entity
- `v` - visualize the simulation using a VCD file
- `w` - open the VCD file in GTKWave

## Examples:
To analyze the files (nand.vhd, inom.vhd, inom_tb.vhd):
```
./g.sh a nand.vhd inom.vhd inom_tb.vhd
```

To elaborate and run the test bench entity (assuming files have been analyzed prior):
```
./g.sh er nand.vhd inom.vhd inom_tb.vhd
```

To delete the .cf file, analyze, elaborate, and run the test bench entity:
```
./g.sh daer nand.vhd inom.vhd inom_tb.vhd
```

To analyze, elaborate, run, visualize, and open in GTKWave:
```
./g.sh aervw nand.vhd inom.vhd inom_tb.vhd
```
	
## Notes:
- Files must be listed in the correct order.
- The test bench file should be the last argument.
- The entity to be tested should be the second to the last argument.
- Options are executed in order they are listed by the user.