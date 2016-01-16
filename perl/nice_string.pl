#!/usr/bin/env perl

use strict;
use warnings;
use 5.022;

use IO::All;

if(scalar @ARGV < 1) {
  say "Usage: nice_string.pl <input_file>";
  exit();
}

my $input = read_input($ARGV[0]);

# part one - answer 258
my $nice_strings = 0;
foreach my $string (split /\n/, $input) {
    next if($string =~ /ab|cd|pq|xy/);
    next if($string !~ /(\w)\1/);
    my @vowels = $string =~ /([aeiou])/g;
    next unless scalar @vowels >= 3;

    $nice_strings++;
}

say $nice_strings;


# part two - answer 53
$nice_strings = 0;
foreach my $string (split /\n/, $input) {
    next if($string !~ /(\w\w).*?\1/);
    next if($string !~ /(\w)\w\1/);

    $nice_strings++;
}

say $nice_strings;

sub read_input {
    my $file = shift;
    if(-e $file && -f $file) {
        my $input = io->file($file)->slurp;
        return $input;
    } else {
        say $file . " does not exist or is not a file";
        exit();
    }
}
