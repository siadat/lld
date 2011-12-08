use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'App::Lld',
    AUTHOR              => q{Sina Siadat <siadat@gmail.com>},
    VERSION_FROM        => 'lib/App/Lld.pm',
    ABSTRACT_FROM       => 'lib/App/Lld.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'App-Lld-*' },
);
