#!/bin/sh

file_source_base=`basename "$1"`
dest_dir="$2"
MainProg=/usr/home/justin/bin/yasync.sh

if [ -f "$1" ] && [ ! -e "$dest_dir"/"$file_source_base" ]
then
	echo '''' $file_source_base isn\'t in $dest_dir, so I\'m trying to copy it there.Just Wait... && \
	cp "$1" "$dest_dir" && \
	echo '''' Done.
elif [ -d "$1" ] && [ ! -e "$dest_dir"/"$file_source_base" ]
then
	echo '''' "$1" seems not reside on "$dest_dir", So copying the entire hierarchy... && \
	cp -R "$1" "$2" && \
	echo '''' Done...	
elif [ -d "$1" ] && [ -e "$dest_dir"/"$file_source_base" ]
then
	echo Entering $1... && \
	$MainProg "$1" "$dest_dir/$file_source_base"
	echo Done and Out.
fi
