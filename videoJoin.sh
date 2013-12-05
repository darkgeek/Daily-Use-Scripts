# videoJoin.sh
# Author: Justin Yang(darkgeek)
# Download and merge splitted videos together

echo "Trying to download viedo files..."
wget -c -i "$1"

echo "Merging..."
cat "$1" | awk 'BEGIN{FS="/"} {if ($1 !~ /^#/) print $NF}' | xargs -t -i printf "file '%s'\n" {} > mylist.txt
ffmpeg -f concat -i mylist.txt -c copy output.mp4

echo "Removing temp files..."
cat "$1" | awk 'BEGIN{FS="/"} {if ($1 !~ /^#/) print $NF}' | xargs -t -i rm {}
rm "$1"
rm mylist.txt
