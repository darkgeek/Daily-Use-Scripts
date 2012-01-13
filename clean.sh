#!/bin/sh

file_source_base=`basename "$1"`
dest_dir="$2"

if [ -f "$1" ] && [ ! -e "$2"/"$file_source_base" ]
then
	echo '''' "$file_source_base" isn\'t at "$2", so just removing it...
	rm "$1"
	echo '''' Done.
elif [ -d "$1" ] && [ ! -e "$2"/"$file_source_base" ]
then
	echo '''' "Removing the whole hierachy $file_source_base ..."
	rm -r "$1"
	echo '''' Done.
fi


