#!/bin/bash


echo "Generating ctags..."
ctags -R --languages=C,C++ --c-kinds=+p --fields=+iaS --extras=+q

echo "Generating cscope.files..."
find . -type f \( -name "*.[ch]" -o -name "Makefile" -o -name "*.mk" -o -name "CMakeLists.txt"   \) > cscope.files
echo "Building cscope.out..."
cscope -b -q -k -i cscope.files
echo "Done."
