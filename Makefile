VC=verilator
VFLAGS=-Wall --cc --trace
CC=g++
DEBUG=-g
CFLAGS='-std=c++14 -W -Wall -pedantic $(DEBUG)'
INDENTFLAGS='-nip -npsl -br -bls -brf -ip4 -npcs -nce -sbi2 -ts1 -bad -bap -nsob'


FILE=MODULENAME
DOCTEST=doctest_main

doctest:
	$(CC) -c $(DOCTEST).cpp

verilator:
	$(VC) $(VFLAGS) -CFLAGS $(CFLAGS) $(FILE).sv --exe tb_$(FILE).cpp ../$(DOCTEST).o src/*.cpp

port:
	python3 scripts/parsePorts.py

testbench:
	make -j -C obj_dir/ -f V$(FILE).mk V$(FILE)

build: | verilator port

run-tb: testbench
	obj_dir/V$(FILE)

run: | verilator testbench
	obj_dir/V$(FILE)

debug: | verilator testbench
	gdb obj_dir/V$(FILE)

wave:
	gtkwave trace/trace.vcd trace/trace.sav &

all: | verilator port testbench run wave

clean:
	rm -rf obj_dir
	rm -f trace/trace.vcd
	rm -f include/port.hpp src/port.cpp
	rm -f $(DOCTEST).o

format:
	indent $(INDENTFLAGS) tb_$(FILE).cpp -o tb_$(FILE).cpp

update: clean
	cp /home/brad/Projects/verilog/PROJECT/src/Testbench.cpp src/
	cp /home/brad/Projects/verilog/PROJECT/include/Testbench.hpp include/
	cp /home/brad/Projects/verilog/PROJECT/scripts/parsePorts.py scripts/
	sed -i -- 's/MODULENAME/'"$(FILE)"'/g' include/Testbench.hpp src/Testbench.cpp scripts/parsePorts.py scripts/makeSubModule.py

