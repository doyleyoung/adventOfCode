#!/usr/bin/env perl6

use v6;

use Digest::MD5;

# why so slow? Something to investigate?
# given secret key bgvyzdsv
# first answer (five zeros) is 254575
# second answer (six zeros) is 1038736

sub MAIN($secret_key) {
    my $int = 1;
    my $d = Digest::MD5.new;

    while True {
        my $digest = $d.md5_hex($secret_key ~ $int);
        if substr($digest, 0, 5) eq "00000" {
        # if substr($digest, 0, 6) eq "000000" {
            say $int;
            exit();
        }

        $int++;
    }
}
