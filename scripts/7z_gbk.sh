#!/bin/sh
#
# Extract data from an archive file with GBK encoding inside
# Author: Justin Yang (linuxjustin at gmail.com)
# Dependencies: p7zip convmv

DATE=`date "+%Y%m%d%H%M%S"`
WORKDIR="/tmp/workdir-$DATE"
ARCHIVE_FILE="$1"
SCRIPT_NAME="$0"
FROM_ENCODING="gbk"
TO_ENCODING="utf8"
USER_LOCALE=$LC_ALL

say() {
    local msg="$1"
    local script=`basename $SCRIPT_NAME`
    
    printf "[$script] %s\n" "$msg"
}

help() {
    say "Usage: $SCRIPT_NAME [archive_file]"
}

if [ X"" = X"$ARCHIVE_FILE" ]; then
    help
    exit 0
fi

# Test if 7z is installed
which 7z > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
    say "7z is not in your PATH. Aborted."
    exit 1
fi

# Test if convmv is installed
which convmv > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
    say "convmv is not in your PATH. Aborted."
    exit 1
fi

# Test if the specified archive file is accessible
if [ ! -f "$ARCHIVE_FILE" ]; then
    say "The file $ARCHIVE_FILE is not accessible. Aborted."
    exit 2
fi

say "Creating temp workdir..."
mkdir $WORKDIR && say "Done." || exit 6

say "Extracting..."
# Get the absolute path of the specified archive file
ARCHIVE_FILE=`readlink -f "$ARCHIVE_FILE"`
cd $WORKDIR
# Set the locale to C. It's a must for correct encoding for the following steps
LC_ALL=C
7z x "$ARCHIVE_FILE" && say "Done." || exit 3

say "Performing encoding convertion operation..."
convmv -r -f $FROM_ENCODING -t $TO_ENCODING --notest * && say "Done." || exit 4

cd -
LC_ALL=$USER_LOCALE
say "Moving..."
mv $WORKDIR/* . && say "Done." || exit 5

say "Removing temp workdir..."
rm -rf $WORKDIR && say "Done." || exit 7

say "Congratulations!"
