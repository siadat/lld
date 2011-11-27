#!/usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor;

my @prev_words = [];

while(<>) {
  my @words = split(/(.)/, $_);
  while((my $key, my $w) = each(@words)) {
    if ($prev_words[$key] and $prev_words[$key] eq $w) {
      print $w;
    } else {
      $w =~ s/(.*)/colored($+, 'cyan')/eg;
      print $w;
    }
  }
  @prev_words = @words;
}
