#! /bin/bash

fail=0

# check for readme file in current repo
top=$(find . -maxdepth 1 -type f -iname *readme* | wc -l)
if [ $top -gt 0 ]; then
    echo "readme found in current repo"
else
    echo "missing readme in current repo"
    fail=1
fi


# check for readme files in submodules
subs=$(git submodule | wc -l)
subswo=$(git submodule foreach --quiet  '[ "$(find . -maxdepth 1 -type f -iname *readme*)" ] || echo  $name' | wc -l)

echo "$subswo/$subs submodules without readme file in top level dir"
echo "list of affected submodules:"
git submodule foreach --quiet  '[ "$(find . -maxdepth 1 -type f -iname *readme*)" ] || echo  $name'


# show result
if [ $(($fail+$subswo)) -gt 0 ]; then
    echo "*** FAIL (some readme files missing)"
else
    echo "--- SUCCESS ---"
fi
