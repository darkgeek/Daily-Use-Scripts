#!/usr/bin/env perl

use strict;
use 5.010;
use warnings;

my $extractor = '(http[s]?://.*\.org/f/.*\.gz): 302 Redirection \(ignored\)';
my $downloader_cmd = 'wget -c';
my $downloader_destination_option = '-P';
my $destination = '/var/db/portsnap/files/';

while (defined(my $line = <STDIN>)) {
    chomp($line);
    if ($line =~ $extractor) {
        say "Tring to refetch patches...";
        `$downloader_cmd $1 $downloader_destination_option $destination` or say "Unable to fetch it: $!";
        say "Done.";
    }
}
