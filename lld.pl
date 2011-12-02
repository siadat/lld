#!/usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor;
use Algorithm::Diff;
use utf8;

my $DEBUG_MODE = 0;
my @prev_words = ();
my @new_words = my @words = [];

if ($DEBUG_MODE) {
  use Data::Dumper;
  $Data::Dumper::Indent = 0;
}

while(<>) {
  utf8::decode($_);
  @new_words = @words = split(/(\W)/, $_);
  my @hunks = Algorithm::Diff::diff(\@prev_words, \@words);

  if($DEBUG_MODE) {
    print "\n " . Dumper(@hunks);
  }

  foreach my $hunk (@hunks) {
    foreach my $diff (@{$hunk}) {
      my @x = @{$diff};
      my $operand = $x[0];
      my $index = $x[1];
      my $str = $x[2];
      if ($operand eq "+") {
        if($DEBUG_MODE) {
          utf8::encode($str);
          print "Add($index, $str) ";
        } else {
          ${new_words[$index]} = colored($str, 'cyan');
        }

      }
    }
  }

  if($DEBUG_MODE) {
    print "\n== NEXT LINE ==\n";
  } else {
    while((my $key, my $w) = each(@new_words)) {
      utf8::encode($w);
      print $w;
    }
  }

  @prev_words = @words;
}
