use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'SUTL::TimeUtl',
    license             => 'artistic2',
    dist_author         => 'Toshiaki Yokoda <adokoy001@gmail.com>',
    dist_version_from   => 'lib/SUTL/TimeUtl.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'SUTL-TimeUtl-*' ],
);

$builder->create_build_script();
