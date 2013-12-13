# videoJoin.sh
# Author: Justin Yang(darkgeek)
# Download and merge splitted videos together

EXPECTED_ARGS=1
TMP_FILE="/tmp/videos.tmp"
JOIN_TMP_FILE="mylist.txt"
OUTPUT_FILE="output.mp4"
BROWSER_AGENT="firefox"


if [ $# -ne  $EXPECTED_ARGS ]
then
	echo "Usage: `basename $0` {Your m3u like video list file path}"
	exit 1
fi

echo "Trying to download viedo files..."
cat "$1" | awk 'BEGIN{number=0} {if ($1 !~ /^#/) {cmd="echo wget -c -U" " '"$BROWSER_AGENT"' " $0 " -O " number ; system(cmd); print number++ >> "'"$TMP_FILE"'"}}'

echo "Merging..."
cat "$TMP_FILE" | xargs -t -i printf "file '%s'\n" {} > "$JOIN_TMP_FILE"
ffmpeg -f concat -i "$JOIN_TMP_FILE" -c copy "$OUTPUT_FILE"

echo "Removing temp files..."
cat "$TMP_FILE" | xargs -t -i rm {}
rm "$TMP_FILE"
rm "$1"
rm "$JOIN_TMP_FILE"
