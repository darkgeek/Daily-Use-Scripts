#!/usr/bin/env perl
use strict;
use 5.010;
use warnings;
use utf8;

use Encode;

open my $file, shift
    or die "Unable to open the file. Aborted. $!";

my $str = '';
while (<$file>) {
    $str = $_;
    while ($str =~ /([\x{E4}-\x{E9}][\x{80}-\x{BF}][\x{80}-\x{BF}])/g) { #只要确定中文在UTF-8中的范围即可
        print decode("utf8",$1), "\n";
    }
}

close($file);
