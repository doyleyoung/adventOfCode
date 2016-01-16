#!/usr/bin/env perl6

use v6;

sub MAIN($file) {
    my $input = read_input($file);
    solve_part_one($input);  # 2572
    solve_part_two($input);  # 2631
}

sub solve_part_one($input) {
    my $x = 0;
    my $y = 0;
    my %visited = ();
    %visited{$x}{$y} = 1;

    for (split '', $input).list -> $direction {
        given $direction {
            when "^" { $y++; }
            when "v" { $y--; }
            when ">" { $x++; }
            when "<" { $x--; }
            default  { next; }
        }

        if %visited{$x}{$y}.defined {
            %visited{$x}{$y}++;
        } else {
            %visited{$x}{$y} = 1;
        }
    }

    say "Santa alone visits " ~ visited_count(%visited);
}

sub solve_part_two($input) {
    my @sr_pos = ();
    @sr_pos[0][0] = 0;  # santa x = 0
    @sr_pos[0][1] = 0;  # santa y = 0
    @sr_pos[1][0] = 0;  # robot x = 0
    @sr_pos[1][1] = 0;  # robot y = 0
    my %both_visited = ();
    %both_visited{0}{0} = 2;  # both start here
    my $active = 0;  # santa moves first

    for (split '', $input).list -> $direction {
        given $direction {
            when "^" { @sr_pos[$active][1]++; }
            when "v" { @sr_pos[$active][1]--; }
            when ">" { @sr_pos[$active][0]++; }
            when "<" { @sr_pos[$active][0]--; }
            default  { next; }
        }

        my $active_x = @sr_pos[$active][0];  # haha, see what I did there?
        my $active_y = @sr_pos[$active][1];
        if %both_visited{$active_x}{$active_y}.defined {
            %both_visited{$active_x}{$active_y}++;
        } else {
            %both_visited{$active_x}{$active_y} = 1;
        }

        $active = $active == 0 ?? 1 !! 0;
    }

    say "Santa and robot santa visited " ~ visited_count(%both_visited);
}

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

sub visited_count(%visited) {
    my $total = 0;

    for %visited.keys -> $key {
        $total += %visited{$key}.elems;
    }

    return $total;
}