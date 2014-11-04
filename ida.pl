#!/usr/bin/perl -w

# Look for one of the texts in column colno of each  line.
# If found, add $new as new column,
# and if not found, add the column itself as new column.

my $colno = 1;   # Which column to search in.
my @old = ('Her-by', 'Ejby', 'herby');	# The possible strings that wil trigger a replacement.
my $new = 'REST';   # The replacement if one of @old is found.

while (<>) {
    chomp;
  my @parts = split(/;/);

  my $found=0;

  foreach my $oldname (@old) {
    if ($parts[$colno] =~ /$oldname/i) {
        push(@parts, $new);
        $found = 1;
        last;
    }
  }

  if ($found == 0) {
      push(@parts, $parts[$colno]);
  }
  print join(';', @parts), "\n";

}

  
	
