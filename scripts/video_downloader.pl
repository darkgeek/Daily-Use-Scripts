#!/usr/bin/env perl
# Author: Justin Yang
# Requirements: mencoder wget libwww-perl p5-File-Which 

use 5.010;
use warnings;
use strict;

use LWP::Simple qw($ua getstore get);
use File::Basename qw(basename);
use File::Which qw(which);
use URI;

# Process the command line
die "Usage: $0 [\$url] [fluent|high|super|super2]\n" if @ARGV < 1;

my $keyword = "$ARGV[0]";
my $format = "";

if (@ARGV > 1) {
	$format = "$ARGV[1]";
}
# End of command line process

my $progname = basename $0; 
my $link_pattern = '<input type="hidden" name="inf" value="(?<video_link>.*)"';
my $seperator = '\|';
my $success_code = 200;
my $uri = "http://www.flvcd.com/parse.php?format=$format&kw=$keyword&go=1";
my @videos = qw//;
my $output_filename = "output.avi";

say "[$progname] Trying to fetch source document...";
my $source_document = get($uri);
die "[$progname] Source Document is not available!" if ! defined $source_document;
say "[$progname] Done.";

# Start parse the downloaded flvcd html document
foreach my $line (split /^/, $source_document) {
	if ($line =~ m#$link_pattern#) {
		my @video_links = split /$seperator/, $+{video_link};

		my $video_number = 0;
		foreach my $link (@video_links) {
			say "[$progname] Trying to download it: $link";
			
			if (-e $video_number) {
				say "[$progname] $video_number aleardy exists! No need to download.";
				push @videos, $video_number;
				$video_number += 1;
				next;
			}
			my $rc = &download_file($link, $video_number);
			say "[$progname] Done.";
			die "[$progname] Unable to download videos!" if $rc != 0;

			push @videos, $video_number;
			$video_number += 1;
		}
	}
}

&merge_videos(@videos);
say "[$progname] Removing temp files...";
unlink @videos;
say "[$progname] Done.";

sub download_file {
	my($link, $filename) = @_;
	my $agent = "Mozilla/5.0 (X11; FreeBSD amd64; rv:38.0) Gecko/20100101 Firefox/38.0";
    my $downloader = 'wget';
    my $cmd = "$downloader -c -U \"$agent\" \"$link\" -O $filename";
    my $rc = 1;

    # Check if wget is installed
    unless (which("$downloader")) {
        die "[$progname] $downloader is not in your PATH. Aborted.";
    }

    # Start downloading...
    system($cmd);

    if ($? == -1) {
        die "[$progname] Failed to execute the command: $cmd";
    }
    elsif ($? & 127) {
        printf "[$progname] Command [$cmd] died with signal %d, %s coredump\n",
            ($? & 127), ($? & 128) ? 'with' : 'without';
        die "[$progname] Aborted.";    
    }
    else {
        # Get the real return value of the command
        $rc = $? >> 8;
    }
	
	return $rc;
}

sub merge_videos {
	my @splits = @_;

	say "[$progname] Trying to merge...";
	if (@splits == 1) {
		rename '0', "$output_filename";
		say "[$progname] Done.";
		return;
	}
	my @merge_cmd = ('mencoder');

	push @merge_cmd, '-ovc';
	push @merge_cmd, 'copy';
	push @merge_cmd, '-oac';
	push @merge_cmd, 'pcm';
	push @merge_cmd, @splits;
	push @merge_cmd, '-o';
	push @merge_cmd, "$output_filename";

	system(@merge_cmd);
	say "[$progname] Done."
}
