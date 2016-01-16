#!/usr/bin/env perl6

use v6;

sub MAIN($file) {
    my $input = read_input($file);
    solve_part_one($input);  # 258
    #solve_part_two($input);  # 53
}

sub solve_part_one($input) {
    my $nice_strings = 0;

    for split /\n/, $input -> $string {
        next if $string ~~ m/ab|cd|pq|xy/;
        next if $string !~~ m/(\w)$0/;
        my @vowels = $string ~~ m:g/(<[aeiou]>)/;
        next unless @vowels.elems >= 3;

        $nice_strings++;
    }

    say $nice_strings;
}


# part two - answer 53
#$nice_strings = 0;
#foreach my $string (split /\n/, $input) {
#    next if($string !~ /(\w\w).*?\1/);
#    next if($string !~ /(\w)\w\1/);
#
#    $nice_strings++;
#}

#say $nice_strings;

sub read_input($file) {
    if $file.IO.e && $file.IO.f {
        my $fh = open $file, :r;
        my $input = $fh.slurp-rest;
        $fh.close;
        return $input;
    } else {
        say "'$file' does not exist or is not a file";
        exit();
    }
}