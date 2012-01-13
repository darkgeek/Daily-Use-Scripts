#!/bin/sh
# This is the Main Script, which accepts two parameter, SourceDir as the first while DestDir as another one. It's used to sync between SourceDir and DestDir, with reference to SourceDir. Futhermore, it's wise to treat DestDir as the exact duplication or "mirror" of the SourceDir

# The path of two important shell program, should be removed in the future
BackupProg=/usr/home/justin/bin/backup.sh
CleanProg=/usr/home/justin/bin/clean.sh


# The Usage of this script
usage () {
	cat << EOF
yasync.sh: Yet Another Sync Shell Script 1.0

USAGE: 
yasync.sh [SourceDir] [DestDir]
EOF
}

# if the parameter given isn't a valid directory, invoke usage() and exit
if [ ! -d "$1" ] || [ ! -d "$2" ]
then
	usage
	exit 0
fi

# If the DestDir specified doesn't exist, just copy the whole hierarchy you specified as first parameter to Destination 
if [ ! -e "$2" ]
then
	echo "$2" isn\'t there, so I just copy the whole hierarchy...
	cp -R "$1" "$2"
	echo Done And Exit.
	exit 0
fi

# Start to Backup, Say, copy the files "living" in SourceDir but absent in DestDir to the latter
find "$1" ! -name "." -depth 1 -print0 | xargs -0 -I % $BackupProg % "$2" 

# Start to Clean, Nay, remove the file in DestDir without a copy in SourceDir, which's considered as an obsolete one  
find "$2" ! -name "." -depth 1 -print0 | xargs -0 -I % $CleanProg % "$1" 

# Run this script in "Parallel" mode
#find "$1" ! -name "." -depth 1 -print0 | xargs -P 4 -0 -I % $BackupProg % "$2" 
