#!/bin/sh

filename=`basename -s .flac "$1"`

flac -d "$1" -o ~/temp.wav && cd ~/ && lame -V 0 temp.wav "$filename".mp3 && rm temp.wav && ls -lGh "$filename".mp3

echo "OK Now, Sir!"

