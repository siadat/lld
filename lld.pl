#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Term::ANSIColor;
use Algorithm::Diff;

my @prev_words = ();
my @words = [];

while(<>) {
  $_ = Term::ANSIColor::colorstrip($_);
  utf8::decode($_);

  @words = split(/(\W)/, $_);
  my @hunks = Algorithm::Diff::diff(\@prev_words, \@words);
  @prev_words = @words;

  foreach my $hunk (@hunks) {
    foreach my $diff (@$hunk) {
      my ($operand, $index, $str) = @$diff;
      $words[$index] = colored($str, 'cyan') if ($operand eq "+");
    }
  }

  my $newline = join('', @words);
  utf8::encode($newline);
  print $newline;
}
