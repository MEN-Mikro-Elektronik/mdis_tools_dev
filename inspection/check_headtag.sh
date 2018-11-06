#! /bin/bash

fail=0

# return head logs of all repos
function headlog {
    printf "%s : " ${PWD##*/}; git --no-pager show --summary --oneline --pretty=format:"%h %d" | head -1
    git submodule foreach --quiet 'printf "%s : " $(basename $(git remote get-url origin) .git); git --no-pager show --summary --oneline --pretty=format:"%h %d" | head -1'
}

# check tag, must be <modulename>_xx_xx
function checktag {
    line=$*
    illtag=0

    tag=$( echo $line | sed -e 's/.*tag: \([^,]*\),.*/\1/' )

    name=$( echo $line | sed -e 's/\(.*\) :.*/\1/' )

    if [[ $tag == $name* ]]; then
        ver=$(echo $tag | sed -e "s/$name\_\(.*\).*/\1/")
        [[ $ver == [0-9][0-9]_[0-9][0-9] ]] || illtag=1
    else
        illtag=1
    fi

    [[ $illtag = 1 ]] && fail=1 && echo "$line : illegal tag : $tag "
}

# check head, must be commit with master and tag
function checkhead {
    line=$*
    om=0; m=0; t=0

    [[ $line = *" origin/master"* ]] && om=1
    [[ $line = *" master"* ]] && m=1
    [[ $line = *" tag: "* ]] && t=1 

    if [[ $((om+m+t)) < 3 ]]; then
        echo -n "$line : missing "
        [[ $om == 0 ]] && echo -n "origin/master " 
        [[ $m == 0 ]] && echo -n "master " 
        [[ $t == 0 ]] && echo -n "tag" 
        echo
        fail=1
    fi

    [[ $t == 1 ]] && checktag $line
}

while read -r line; do
    checkhead $line
done <<< $(headlog)

# show result
if [[ $fail -gt 0 ]]; then
    echo "*** FAIL"
else
    echo "--- SUCCESS ---"
fi
