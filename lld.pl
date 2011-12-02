#!/usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor;
use Algorithm::Diff;

my $DEBUG_MODE = 0;
my @prev_words = ();
my @new_words = my @words = [];

if ($DEBUG_MODE) {
  use Data::Dumper;
  $Data::Dumper::Indent = 0;
}

while(<>) {
  @new_words = @words = split(/(\W)/, $_);
  my @s_diff = Algorithm::Diff::diff(\@prev_words, \@words);

  if($DEBUG_MODE) {
    print "\n== " . Dumper(@s_diff);
  }

  foreach my $hunk (@s_diff) {
    foreach my $diff (@{$hunk}) {
      my @x = @{$diff};
      my $operand = $x[0];
      my $index = $x[1];
      my $str = $x[2];
      if ($operand eq "+") {
        if($DEBUG_MODE) {
          print "Add($index, ${words[$index]}) ";
        } else {
          ${new_words[$index]} = colored(${words[$index]}, 'cyan');
        }

      }
    }
  }

  if($DEBUG_MODE) {
    print "\n== NEXT LINE ==\n";
  } else {
    while((my $key, my $w) = each(@new_words)) {
      print $w;
    }
  }

  @prev_words = @words;
}
