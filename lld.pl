#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Term::ANSIColor;
use Algorithm::Diff;

my @prev_words = ();
my @new_words = my @words = [];

while(<>) {
  $_ = Term::ANSIColor::colorstrip($_);
  utf8::decode($_);
  @new_words = @words = split(/(\W)/, $_);
  my @hunks = Algorithm::Diff::diff(\@prev_words, \@words);

  foreach my $hunk (@hunks) {
    foreach my $diff (@{$hunk}) {
      my @x = @{$diff};
      my $operand = $x[0];
      my $index = $x[1];
      my $str = $x[2];
      if ($operand eq "+") {
        ${new_words[$index]} = colored($str, 'cyan');
      }
    }
  }

  my $newline = join('', @new_words);
  utf8::encode($newline);
  print $newline;

  @prev_words = @words;
}
