#! /bin/bash

fail=0

# get total number of .c/.h files
src=$(find . -type f \( -name "*.c" -or -name "*.h" \) | wc -l)

# get number of .c/.h files without GNU license note
srcwo=$(find . -type f \( -name "*.c" -or -name "*.h" \) -exec grep -HiRnL "GNU General Public License" {} \; | wc -l)

echo "$srcwo/$src .c/.h files without GNU license note"

echo "list of affected files"
find . -type f \( -name "*.c" -or -name "*.h" \) -exec grep -HiRnL "GNU General Public License" {} \;

# show result
if [ $srcwo -gt 0 ]; then
    echo "*** FAIL (some .c/.h files without GNU license note)"
else
    echo "--- SUCCESS ---"
fi
