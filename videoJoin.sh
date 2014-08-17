#!/bin/sh

# videoJoin.sh
# Author: Justin Yang(darkgeek)
# Download and merge splitted videos together

EXPECTED_ARGS=1
OUTPUT_FILE="output.mp4"
BROWSER_AGENT="firefox"
IGNORE_LINE_PATTERN="^#"


if [ $# -ne  $EXPECTED_ARGS ]
then
	echo "Usage: `basename $0` {Your m3u like video list file path}"
	exit 1
fi

echo "[`basename $0`] Trying to download viedo files..."
number=0
video_numbers=""
while IFS=$'\r\n' read line; 
do 
	if [ $(expr "$line" : $IGNORE_LINE_PATTERN) -le 0 ]
	then
		wget -c -U "$BROWSER_AGENT" "$line" -O $number
		video_numbers=`echo $video_numbers $number`
		number=$(expr $number + 1)
	fi
done < "$1"

echo "[`basename $0`] Merging..."
mencoder  -ovc copy -oac pcm $video_numbers -o $OUTPUT_FILE

echo "[`basename $0`] Removing temp files..."
rm $video_numbers
rm "$1"
