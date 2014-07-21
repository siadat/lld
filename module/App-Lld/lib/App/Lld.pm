package App::Lld;

use strict;
use warnings;

=head1 NAME

App::Lld - Sequential Diff.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Highlight the difference between a record (e.g. a line) with the previous one.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub prepare_record {
  $1 = Term::ANSIColor::colorstrip($1);
  utf8::decode($1);
  return $1;
}

=head2 function1

=cut
sub split_record {
  return split(/([\W_])/, $1);
}

=head2 function1

=cut
sub highlight_new {
  my @hunks = Algorithm::Diff::diff(\@{$1}, \@{$2});
  foreach my $hunk (@hunks) {
    foreach my $diff (@$hunk) {
      my ($operand, $index, $str) = @$diff;
      $2[$index] = colored($str, 'cyan') if ($operand eq "+");
    }
  }
  return $2;
}

=head1 AUTHOR

Sina Siadat, C<< <siadat at gmail dot com> >>

=head1 BUGS

Please report any bugs or feature requests to the issue list at Github: L<http://github.com/sinas/lld/issues>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sina Siadat.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of App::Lld
