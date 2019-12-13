#! /bin/bash

sum=0
errhead=0
errtag=0

# return head logs of all submodule repos
function headlog {
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
		# pciutils has special version, e.g. 3.5.5_04
		if [[ $name == "pciutils" ]]; then
			[[ $ver == *([0-9.])_[0-9][0-9] ]] || illtag=1
		else
			[[ $ver == [0-9][0-9]_[0-9][0-9] ]] || illtag=1
		fi
    else
        illtag=1
    fi

    if [[ $illtag = 1 ]]; then
        echo "$line : illegal tag : $tag "
        ((errtag++))
    fi
}

# check head, must be at tagged commit
function checkhead {
    line=$*
    t=0
    ((sum++))

    [[ $line = *" tag: "* ]] && t=1 

    if [[ $((om+m+t)) < 1 ]]; then
        echo -n "$line : missing "
        [[ $t == 0 ]] && echo -n "tag" 
        echo
        ((errhead++))
    fi

    [[ $t == 1 ]] && checktag $line
}

while read -r line; do
    checkhead $line
done <<< $(headlog)

# show result
echo "Result: $sum submodules, $errhead HEAD errors, $errtag tag errors"
if [[ $((errhead + errtag)) -gt 0 ]]; then
    echo "*** FAIL"
else
    echo "--- SUCCESS ---"
fi
