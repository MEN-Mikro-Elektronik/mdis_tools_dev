#! /bin/bash

fail=0
lic="www.gnu.org/licenses"

# get total number of .c/.h files
src=$(find . -type f \( -name "*.c" -or -name "*.h" \) | wc -l)

# get .c/.h files without GNU license note
files=$(find . -name pciutils -prune -o \( -name "*.c" -or -name "*.h" \) -exec grep -HiRL $lic {} \; )

# count number of .c/.h files without GNU license note
srcwo=$(echo $files | wc -w)

echo "$srcwo/$src .c/.h files without GNU license note (pciutils dir skipped)"

echo "list of affected files"
echo $files | tr " " "\n"

# show result
if [ $srcwo -gt 0 ]; then
    echo "*** FAIL (some .c/.h files without GNU license note)"
else
    echo "--- SUCCESS ---"
fi
