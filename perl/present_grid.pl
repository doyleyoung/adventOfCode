#!/usr/bin/env perl

use strict;
use warnings;
use 5.022;

use IO::All;

if(scalar @ARGV < 1) {
  say "Usage: pressent_grid.pl <input_file>";
  exit();
}

# part one - answer 2572
my $x = 0;
my $y = 0;
my %visited = ();
$visited{$x}{$y} = 1;

my $input = read_input($ARGV[0]);
foreach my $direction (split //, $input) {
    if("^" eq $direction) {
        $y++;
    } elsif("v" eq $direction) {
        $y--;
    } elsif(">" eq $direction) {
        $x++;
    } elsif("<" eq $direction) {
        $x--;
    } else {
        next;
    }

    if(exists $visited{$x}{$y}) {
        $visited{$x}{$y}++;
    } else {
        $visited{$x}{$y} = 1;
    }
}

say "Santa alone visits " . visited_count(\%visited);

# part two - answer 2631
my @sr_pos = ();
$sr_pos[0][0] = 0;  # santa x = 0
$sr_pos[0][1] = 0;  # santa y = 0
$sr_pos[1][0] = 0;  # robot x = 0
$sr_pos[1][1] = 0;  # robot y = 0
my %both_visited = ();
$both_visited{0}{0} = 2;  # both start here
my $active = 0;  # santa moves first

foreach my $direction (split //, $input) {
    if("^" eq $direction) {
        $sr_pos[$active][1]++;
    } elsif("v" eq $direction) {
        $sr_pos[$active][1]--;
    } elsif(">" eq $direction) {
        $sr_pos[$active][0]++;
    } elsif("<" eq $direction) {
        $sr_pos[$active][0]--;
    } else {
        next;
    }

    my $active_x = $sr_pos[$active][0];  # haha, see what I did there?
    my $active_y = $sr_pos[$active][1];
    if(exists $both_visited{$active_x}{$active_y}) {
        $both_visited{$active_x}{$active_y}++;
    } else {
        $both_visited{$active_x}{$active_y} = 1;
    }

    $active = $active == 0 ? 1 : 0;
}

say "Santa and robot santa visited " . visited_count(\%both_visited);

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

sub visited_count {
    my $uniques = shift;
    my $total = 0;

    foreach my $key (keys %$uniques) {
        $total += keys %{$uniques->{$key}};
    }

    return $total;
}
