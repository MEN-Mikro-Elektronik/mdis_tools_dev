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
