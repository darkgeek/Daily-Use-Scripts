#!/usr/bin/env perl

# Concatenate multiple individual srts to a single one
# Author: Justin Yang
# Email: linuxjustin AT gmail.com

use strict;
use warnings;
use 5.010;
use utf8;

use Encode;
use Encode::CN;

opendir(DIR, "./")
    or die "Unable to read the dir: $!\n";

open my $result_filehd, '>:utf8', '../海角七号.srt'
    or die "Unable to write to this file: $!\n";

my $num = 1;

while (my $file = readdir(DIR)) {
    next unless $file =~ /\.srt/;

    open my $fh, '<', "$file"
        or die "Unable to read $file: $!\n";

    while (<$fh>) {
        my $utf8_line;
        chomp;
        
        # Convert from gbk to utf8
        $utf8_line = encode('utf8', decode('gbk', "$_"));

        # Decode it to utf8 so that it can be written to file correctly
        $utf8_line = decode('utf8', $utf8_line);

        # Remove annoying ^M characters
        $utf8_line =~ s///;

        say "Reading from $file: $utf8_line";

        if ($utf8_line =~ /^[0-9]+$/) {
            # Reassign number
            print $result_filehd "$num\n";
            $num++;
        }
        else {
            print $result_filehd "$utf8_line\n";
        }
    }
    print $result_filehd "\n";

    close $fh;
}

say "Done.";

close DIR;
close $result_filehd;
