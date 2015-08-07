#!/usr/bin/env perl

# Download resources from a specified site
# Author: Justin Yang (linuxjustin AT gmail.com)
# Requirement: wget

use strict;
use 5.010;
use warnings;

unless (@ARGV) {
    say "Usage: phttpget base_url [resource_url...]";
    exit 1;
}

my $downloader = "wget -c";
my $protocol = "http://";
my $base_url = $ARGV[0];
my @resource_urls = @ARGV[1 .. $#ARGV];

for my $resource (@resource_urls) {
    `$downloader "$protocol$base_url/$resource"`;
}
