#!/usr/bin/env perl
# Require mencoder and libwww-perl

use 5.010;
use warnings;
use strict;

use LWP::Simple qw($ua getstore get);
use URI;

# Process the command line
die "Usage: $0 [\$url] [fluent|high|super]\n" if @ARGV < 1;

my $keyword = "$ARGV[0]";
my $format = "";

if (@ARGV > 1) {
	$format = "$ARGV[1]";
}
# End of command line process

my $progname = $0; 
my $link_pattern = '<input type="hidden" name="inf" value="(?<video_link>.*)"';
my $seperator = '\|';
my $success_code = 200;
my $uri = "http://www.flvcd.com/parse.php?format=$format&kw=$keyword";
my @videos = qw//;
my $output_filename = "output.mp4";

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
			die "[$progname] Unable to download videos!" if $rc != 200;

			push @videos, $video_number;
			$video_number += 1;
		}
	}
}

merge_videos(@videos);
say "[$progname] Removing temp files...";
unlink @videos;
say "[$progname] Done.";

sub download_file {
	my($link, $filename) = @_;
	my $url = URI->new($link);

	$ua->default_headers( HTTP::Headers->new(
		Accept => '*/*',
		)
	);
	$ua->agent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/534.54.16 (KHTML, like Gecko) Version/5.1.4 Safari/534.54.16");
	my $rc = getstore($url, $filename);
	
	return $rc;
}

sub merge_videos {
	my @splits = @_;
	say "[$progname] Trying to merge...";
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
