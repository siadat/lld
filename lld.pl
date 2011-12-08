#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Term::ANSIColor;
use Algorithm::Diff;

my @prev_words = ();
my @words = [];
$/ = "\n";

while(my $record = <>) {
  $record = Term::ANSIColor::colorstrip($record);
  utf8::decode($record);

  @words = split(/([\W_])/, $record);
  my @hunks = Algorithm::Diff::diff(\@prev_words, \@words);
  @prev_words = @words;

  foreach my $hunk (@hunks) {
    foreach my $diff (@$hunk) {
      my ($operand, $index, $str) = @$diff;
      $words[$index] = colored($str, 'cyan') if ($operand eq "+");
    }
  }

  $record = join('', @words);
  utf8::encode($record);
  print $record;
}
