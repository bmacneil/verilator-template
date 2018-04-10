NEW_MODULE=$1

cp -r PROJECT $NEW_MODULE
cd $NEW_MODULE
mv MODULENAME.sv $NEW_MODULE.sv
mv tb_MODULENAME.cpp tb_$NEW_MODULE.cpp
sed -i -- 's/FILE=MODULENAME/'"FILE=$NEW_MODULE"'/g' Makefile
sed -i -- 's/MODULENAME/'"$NEW_MODULE"'/g' $NEW_MODULE.sv tb_$NEW_MODULE.cpp include/Testbench.hpp src/Testbench.cpp scripts/parsePorts.py scripts/makeSubModule.py
git init
subl -n .