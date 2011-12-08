#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'App::Lld' ) || print "Bail out!\n";
    use_ok( 'App::Lld::Internals' ) || print "Bail out!\n";
}

diag( "Testing App::Lld $App::Lld::VERSION, Perl $], $^X" );
