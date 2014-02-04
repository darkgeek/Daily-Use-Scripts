#!/bin/sh
#
# Sync between source and target
# Requirement: rsync
# Caveat: the filename or directory name shouldn't contain spaces or other special characters

# type_flag: 0 (no action), 1 (source dirs), 2 (destination dir)
type_flag=0

target_dir=""
source_list=""

SOURCE_MARK="[source]"
DEST_MARK="[target]"
RC_FILE=~/.sync.conf

check_if_skip() {
	words=$1
	is_comment_line=0
	comment_mark="^#"

	if [ -z "$words" ] || [ $(expr "$words" : "$comment_mark") -gt 0 ]
	then
		is_comment_line=1
	fi

	return "$is_comment_line"
}

start_sync() {
	source_dir=$1
	dest_dir=$2

	rsync -rvh --progress --delete $source_dir $dest_dir
}

usage() {
	echo ''
	echo "Please configure $RC_FILE first."
	echo 'For instance:'
	echo '    '
	echo "    $SOURCE_MARK               "   
	echo '    /home/justin/Shares/test/aa'
	echo '    /home/justin/Shares/test/bb'
	echo "    $DEST_MARK                 "
	echo '    /media/disk/backup/        '
	echo '   '

	exit 1;
}

if [ ! -f $RC_FILE ]
then
	usage
fi

while read file; do
	check_if_skip "$file"
	is_comment=$?

	if [ "$is_comment" -eq 0 ]
	then
		if [ "$file" = "$SOURCE_MARK" ]
		then
			type_flag=1
			continue
		elif [ "$file" = "$DEST_MARK" ]
		then
			type_flag=2
			continue
		fi

		if [ $type_flag -eq 1 ]
		then
			source_list="$source_list $file"
		elif [ $type_flag -eq 2 ]
		then
			target_dir=$file
		fi

	fi	
done < $RC_FILE

if [ -z "$source_list" ] || [ -z "$target_dir" ]
then
	usage
fi

echo "=============Prepare sync==========="
echo "These files will be synced: " $source_list
echo "Target directory : " $target_dir

echo "=============Start syncing==========="
for d in $source_list; do
	start_sync $d $target_dir
done
echo "=============End syncing==========="
