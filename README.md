# mdis_tools_dev
MDIS tool collection for development and testing.

This repo is intended for MDIS developmen tools.
The tools are grouped in subdirectories.

## git-extensions
This subdirectory contains git extensions.
Copy the git-\* files to a location that is specified in yout PATH variable (e.g. /usr/local/bin).

### git-log-submodule
This git extension shows all commits with the names of the affected files of the current repo and
all included submodules betwenn the current HEAD and the specified older commit hash or tag.

Example usage:
`dpfeuffer@vm-suse:~/work/repos/13MD05-90> git log-sub 13MD05-90_01_20`

Fictitious example output:
```
commit ca6005341bef2f2eb10e6abf80bf1eeaff36380f
Author: Marcin Lassota <mlassota@jpembedded.eu>
Date:   Fri Sep 28 11:32:42 2018 +0200

    R: issue 'mdiswizard formatting error / font not supported #44'
    
    M: updated mdiswiz binary

MDISforLinux/BIN/mdiswiz

13Z025-90: commit 82af0be771d4dabc4ee47c1aee457308f9c9806b
13Z025-90: Author: Marcin Lassota <mlassota@jpembedded.eu>
13Z025-90: Date:   Thu Sep 20 13:29:44 2018 +0200
13Z025-90: 
13Z025-90:     R: compiler warnings on CentOS 6.8 (issue 'MAIN_PR003403 MDIS 1.18 with CentOS 6.8 x64 doesn't load modules automatically #14')
13Z025-90:     
13Z025-90:     M: added proper casting
13Z025-90: 
13Z025-90: DRIVERS/13Z025/men_z25_serial.c

13AD78-06 : ### submodule added  ###

DRIVERS/BBIS/SMBPCI : ### submodule removed ###
```

## inspection

This subdirectory contains tools for the inspection of the MDIS repositories
and MDIS sources.
Copy the tools to a location that is specified in yout PATH variable (e.g. /usr/local/bin).

### check_readme.sh

This shell script verifies for the current repo and all included submodules that a readme file
exists in the top dir of each repo. The script lists all submodules with missing readme files
and prints a success/fail result.

Example usage:
`dpfeuffer@vm-suse:~/work/repos/13MD05-90> check_readme.sh`

Fictitious example output:
```
readme found in current repo
5/70 submodules without readme file in top level dir
list of affected submodules:
13AD78-06
13Z025-90
13Z044-90
DRIVERS/BBIS/A12
TOOLS/WDOG
*** FAIL (some readme files missing)
```

### check_license.sh

This shell script verifies that all .c/.h source files contain a GNU license note.
The script lists all erroneous files and prints a success/fail result.

Example usage:
`dpfeuffer@vm-suse:~/work/repos/13MD05-90> check_license.sh`

Fictitious example output:
```
4/718 .c/.h files without GNU license note
list of affected files
./13M058-06/DRIVERS/MDIS_LL/M058/TOOLS/M58_READ/COM/m58_read.c
./13Z044-90/INCLUDE/NATIVE/MEN/fb_men_16z044.h
./13Z044-90/TOOLS/FB_TEST/fb16z044_test.c
./13Z135-90/DRIVERS/13Z135/men_mdis_z135.c
*** FAIL (some .c/.h files without GNU license note)
```

### check_headtag.sh

This shell script verifies for the current repo and all included submodules that
the head is at a commit with 'master' and 'origin/master' and that the tag
complies to the format \<modulename\>_xx_xx.
The script lists all errors and prints a success/fail result.

Example usage:
`dpfeuffer@vm-suse:~/work/repos/13MD05-90> check_headtag.sh`

Fictitious example output:
```
13MD05-90 : ca60053 (HEAD, tag: 05_01_21, origin/master, origin/HEAD, master) : illegal tag : 05_01_21 
13AD78-06 : e6b1c33 (HEAD, origin/master, origin/HEAD, master) : missing tag
13SC24-91 : 49d7a44 (HEAD, tag: 14SC24-91_01_01, origin/master, origin/HEAD, master) : illegal tag : 14SC24-91_01_01 
13Y007-06 : ec3f6a2 (HEAD) : missing origin/master master tag
LIBSRC/PLD/COM : 01256c8 (HEAD, origin/master, origin/HEAD, master) : missing tag
*** FAIL
```