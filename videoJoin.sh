cat "$1" | awk 'BEGIN{FS="/"} {if ($1 !~ /^#/) print $NF}' | xargs -t -i printf "file '%s'\n" {} > mylist.txt
ffmpeg -f concat -i mylist.txt -c copy output.mp4
