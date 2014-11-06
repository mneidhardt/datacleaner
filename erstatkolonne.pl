#!/usr/bin/perl -w

# Look for one of the texts in column colno of each  line.
# If found, add $new as new column,
# and if not found, add the column itself as new column.

my $colno = 1;   # Which column to search in.
my @old = ('Her-by', 'Ejby', 'herby');	# The possible strings that wil trigger a replacement.
my $new = 'REST';   # The replacement if one of @old is found.

if ($colno !~ /^\d+$/ || $colno < 0) {
  die 'Variablen $colno skal være et heltal i [0,antalkolonner[.',"\n";
}
if (scalar(@old) == 0) {
    die 'Der skal være mindst en tekststreng i listen @old.', "\n";
}


while (<>) {
    chomp;
  my @parts = split(/;/);

  if (scalar(@parts) <= $colno) {
      die "Fandt ", scalar(@parts), " kolonner i inddata, men du har sat colno til $colno.\n$_\n",
          "Husk at den er 0-baseret, så den kan max. være ", (scalar(@parts)-1), " i dette tilfælde.\n";
  }

  my $found=0;

  foreach my $oldname (@old) {
    if ($parts[$colno] =~ /^\s*$oldname\s*$/i) {
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

  
	
