#!/usr/bin/env perl

use strict;
use warnings;
use 5.22.0;

use List::Util qw(reduce);

if(scalar @ARGV < 1) {
  say "Usage: floor.pl <string of parens>";
  exit();
}

say "Last floor: " . reduce { $a + $b } map { $_ eq "(" ? 1 : -1; } split //, $ARGV[0];

my $sum = 0;
my $count = 0;
foreach my $paren (split //, $ARGV[0]) {
  $count++;
  $sum += $paren eq "(" ? 1 : -1;
  if($sum < 0) {
    say "Enter basement at step: " . $count;
    exit();
  }
}

say "never";
