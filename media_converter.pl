#!/usr/bin/env perl
use 5.010;
use strict;

use Getopt::Std;
use File::Which qw(which);
use Carp;

my $opts = {};
getopts('s:o:q:', $opts);

my $source = $opts->{s};
my $output = $opts->{o};
my $quality = $opts->{q} || 'medium';

unless ($source and $output) {
    croak "Usage: $0 -s [source] -o [output] [-q low|medium|high]";
}

my $source_format = get_extension($source);
my $output_format = get_extension($output);

unless ($source_format and $output_format) {
    croak "ERROR: Invalid file extension. You should have extension in your filename, like [source.flac].";
}

my $converter = create_converter($source_format, $output_format);
{
    no strict 'refs';
    $converter->();
}

sub create_converter {
    my ($s_format, $o_format) = @_;
    my $method = $s_format."_to_".$o_format;

    unless ('main'->can($method)) {
        croak "Unsupported convertion: $s_format to $o_format.";
    }

    return $method;
}

sub get_extension {
    my ($extension) = shift =~ /\.([^.]+)$/;

    return $extension;
}

sub logger {
    my $message = shift;

    say "====> $message";
}

sub flac_to_mp3 {
    my $temp_file = time;
    my $tmp_dir = '/tmp';
    my $quality_table = {low => 9, medium => 4, high => 2};
    my $q = $quality_table->{$quality};
    my $flac_cmd_path = which('flac');
    my $lame_cmd_path = which('lame');

    logger("Finding flac: $flac_cmd_path");
    logger("Finding lame: $lame_cmd_path");
    unless ($flac_cmd_path and $lame_cmd_path) {
        croak "ERROR: Missing required external commands. Aborted.";
    }

    my $cmd = "flac -d \"$source\" -o $tmp_dir/$temp_file && lame -V $q $tmp_dir/$temp_file \"$output\" && rm $tmp_dir/$temp_file"; 

    logger("Runing command:\n$cmd");
    system($cmd);
}

sub flac_to_ogg {
    my $quality_table = {low => 0, medium => 3, high => 10};
    my $q = $quality_table->{$quality};
    my $cmd = "oggenc -q $q \"$source\" -o \"$output\"";
    my $oggenc_cmd_path = which('oggenc');

    logger("Finding oggenc: $oggenc_cmd_path");
    unless ($oggenc_cmd_path) {
        croak "ERROR: Missing required external commands. Aborted.";
    }

    logger("Runing command:\n$cmd");
    system($cmd);
}

sub ape_to_mp3 {
    my $temp_file = time;
    my $tmp_dir = '/tmp';
    my $quality_table = {low => 9, medium => 4, high => 2};
    my $q = $quality_table->{$quality};
    my $mac_cmd_path = which('mac');
    my $lame_cmd_path = which('lame');

    logger("Finding mac: $mac_cmd_path");
    logger("Finding lame: $lame_cmd_path");
    unless ($mac_cmd_path and $lame_cmd_path) {
        croak "ERROR: Missing required external commands. Aborted.";
    }

    my $cmd = "mac \"$source\" $tmp_dir/$temp_file -d && lame -V $q $tmp_dir/$temp_file \"$output\" && rm $tmp_dir/$temp_file";

    logger("Runing command:\n$cmd");
    system($cmd);
}

sub ape_to_ogg {
    my $temp_file = time;
    my $tmp_dir = '/tmp';
    my $quality_table = {low => 0, medium => 3, high => 10};
    my $q = $quality_table->{$quality};
    my $mac_cmd_path = which('mac');
    my $oggenc_cmd_path = which('oggenc');

    logger("Finding mac: $mac_cmd_path");
    logger("Finding oggenc: $oggenc_cmd_path");
    unless ($mac_cmd_path and $oggenc_cmd_path) {
        croak "ERROR: Missing required external commands. Aborted.";
    }

    my $cmd = "mac \"$source\" $tmp_dir/$temp_file -d && oggenc -q $q $tmp_dir/$temp_file -o \"$output\" && rm $tmp_dir/$temp_file";

    logger("Runing command:\n$cmd");
    system($cmd);
}
