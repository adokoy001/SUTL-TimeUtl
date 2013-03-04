use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'SUTL::TimeUtl',
    AUTHOR              => 'Toshiaki Yokoda <adokoy001@gmail.com>',
    VERSION_FROM        => 'lib/SUTL/TimeUtl.pm',
    ABSTRACT_FROM       => 'lib/SUTL/TimeUtl.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SUTL-TimeUtl-*' },
);
