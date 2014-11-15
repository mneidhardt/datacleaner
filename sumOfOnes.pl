#!/usr/bin/perl -w

# Sum all ones in a column, and stop when meeting a zero.
# Only do it between fromdate and todate, if they are given as args.
# Expects these arguments:
# filename fromdate todate
# filename is a txt file containing 2 columns separated by semicolon.
# First column is date, and second columns is the number column containing 1 or 0.

my ($fromdate, $todate);

if (scalar(@ARGV) == 3) {
  $todate = pop;
  $fromdate = pop;
} elsif (scalar(@ARGV) == 2) {
  $todate = undef;
  $fromdate = pop;
} else {
  die "Syntax: $0 filnavn fradato [tildato]\n";
}

my $startdatefound=0;
my $lno=0;
my $sum=0;
my $insequence=0;
my @sums;

while (<>) {
    s/\r\n/\n/g;                # Change Windows line ending to Unix.
    chomp;
    ++$lno;

    unless (/^\s*\d+\-\d+\-\d+;\d\s*$/) {
        if ($startdatefound) {  # Stop if startdate found and line illegal.
            last;
        } else {                # Skip line if startdate not found and line illegal.
            next;
        }
    }

    my @parts = split(/;/);

    if (scalar(@parts) != 2) {
        die "Fandt ", scalar(@parts), " kolonner i inddata, forventede 2 i linie $lno.\n$_\n";
    }

    unless ($startdatefound) {
        print "$parts[0] =? $fromdate\n";
        if ($fromdate eq $parts[0]) {
            $startdatefound = 1;
        }
    }

    if ($startdatefound) {
        if ($parts[1] == 1) {
            ++$sum;
            print join(';', @parts),";\n";
        } elsif ($parts[1] == 0) {
            print join(';', @parts), ";$sum\n";
            push(@sums, $sum);
            $sum=0;
        }
    } else {
        print "$_;\n";
    }
}

print "$lno lines. ", join(" ", @sums), "\n";


  
	
