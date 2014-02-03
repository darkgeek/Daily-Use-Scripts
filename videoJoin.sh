#!/bin/sh

# videoJoin.sh
# Author: Justin Yang(darkgeek)
# Download and merge splitted videos together

EXPECTED_ARGS=1
TMP_FILE="videos.tmp"
JOIN_TMP_FILE="mylist.txt"
OUTPUT_FILE="output.mp4"
BROWSER_AGENT="firefox"
IGNORE_LINE_PATTERN="^#"


if [ $# -ne  $EXPECTED_ARGS ]
then
	echo "Usage: `basename $0` {Your m3u like video list file path}"
	exit 1
fi

echo "[`basename $0`] Cleaning old temp files..."
rm "$TMP_FILE" > /dev/null 2>&1
rm "$JOIN_TMP_FILE" > /dev/null 2>&1

echo "[`basename $0`] Trying to download viedo files..."
number=0
while IFS=$'\r\n' read line; 
do 
#	if [[ ! "$line" =~ $IGNORE_LINE_PATTERN ]] 
	if [ $(expr "$line" : $IGNORE_LINE_PATTERN) -le 0 ]
	then
		wget -c -U "$BROWSER_AGENT" "$line" -O $number
		echo $number >> "$TMP_FILE"
		number=$(expr $number + 1)
	fi
done < "$1"

echo "[`basename $0`] Merging..."
cat "$TMP_FILE" | xargs -t -I{} printf "file '%s'\n" {} > "$JOIN_TMP_FILE"
ffmpeg -f concat -i "$JOIN_TMP_FILE" -c copy "$OUTPUT_FILE"

echo "[`basename $0`] Removing temp files..."
cat "$TMP_FILE" | xargs -t -I{} rm {}
rm "$TMP_FILE"
#rm "$1"
rm "$JOIN_TMP_FILE"
