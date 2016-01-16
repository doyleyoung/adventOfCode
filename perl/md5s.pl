#!/usr/bin/env perl

use strict;
use warnings;
use 5.022;

use Digest::MD5 qw(md5_hex);

if(scalar @ARGV < 1) {
  say "Usage: md5s.pl <secret_key>";
  exit();
}

# given secret key bgvyzdsv
# first answer (five zeros) is 254575
# second answer (six zeros) is 1038736

my $int = 1;
while(1) {
    my $digest = md5_hex($ARGV[0] . $int);
    # if(substr($digest, 0, 5) eq "00000") {
    if(substr($digest, 0, 6) eq "000000") {
        say $int;
        exit();
    }

    say $int if($int % 1000000 == 0);

    $int++;
}
