#! /bin/bash

pkgsum=0
pkgerr=0
err=0

check_file (){
    if test ! -f $1 ; then
        echo "*** $2=$1 not found"
        (( err++ ))
        return 1
    fi
    return 0
}

# get entity, content and tag name
read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
    local ret=$?
    TAG_NAME=${ENTITY%% *}
    return $ret
}

# interpret entity, content and tag name
parse_dom () {

    # find <swmodule>
    case $TAG_NAME in
    swmodule)
        swmodule=1
        ATTRIBUTES=${ENTITY#* }
        if [[ $ATTRIBUTES = swmodule ]]; then
            swm_attr=
        else
            swm_attr=$ATTRIBUTES
        fi
        ;;
    /swmodule)
        swmodule=0
        check_file $swm_basepath/$swm_makefilepath "<makefilepath>"
        if [[ $? = 1 ]]; then
            echo "    name: $swm_name"
            echo "    desc: $swm_desc"
            echo "    type: $swm_type"
            [ -z $swm_attr ] || echo "    attr: $swm_attr"
        fi
        ;;
    *)
        ;;
    esac

    # parse <package> 
    if [[ $pkg_name = "" ]] && [[ $TAG_NAME = name ]]; then
        pkg_name=$CONTENT
    elif [[ $pkg_desc = "" ]] && [[ $TAG_NAME = description ]]; then
        pkg_desc=$CONTENT
        echo "--- $file_name: $pkg_desc ---"
        if [[ $pkg_name.xml != $file_name ]]; then
            echo "*** <name>:$pkg_name != file-name:$file_name"
            (( err++ ))
        fi
    elif [[ $pkg_docroot = "" ]] && [[ $TAG_NAME = docroot ]]; then
        pkg_docroot=$CONTENT
        check_file $pkg_docroot "<docroot>"
    fi

    # parse <swmodule>
    if [[ $swmodule = 1 ]]; then
        case $TAG_NAME in
        name)
            swm_name=$CONTENT
            ;;
        description)
            swm_desc=$CONTENT
            ;;
        type)
            swm_type=$CONTENT 
            case $CONTENT in
            'Low Level Driver')
                swm_basepath="DRIVERS/MDIS_LL"
                ;;
            'User Library')
                swm_basepath="LIBSRC"
                ;;
            'Driver Specific Tool')
                swm_basepath="DRIVERS/MDIS_LL"
                ;;
            'Common Tool')
                swm_basepath="TOOLS"
                ;;
            'Native Driver')
                swm_basepath="."
                ;;
            'Native Tool')
                swm_basepath="."
                ;;
            *)
                echo "*** unknown type"
                ;;
            esac
            ;;
        makefilepath)
            swm_makefilepath=$CONTENT 
            ;;
        *)
            ;;
        esac
    fi
}

# parse one xml file
parse_file () {
    (( pkgsum++ ))
    pkg_name=
    pkg_desc=
    pkg_docroot=
    tmp_err=$err
    file_name=$(basename $file_path)
    while read_dom; do
        parse_dom
    done < $file_path
    [[ $err -gt $tmp_err ]] && (( pkgerr++ ))
}

# parse all xml files
for file_path in PACKAGE_DESC/*.xml; do
    parse_file
done

# show result
echo "Result: $pkgsum .xml files checked, $err errors in $pkgerr .xml files"
if [[ $err = 0 ]]; then
    echo "--- SUCCESS ---"
else
    echo "*** FAIL"
fi
