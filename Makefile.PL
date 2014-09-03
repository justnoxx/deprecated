use strict;
use warnings;
use 5.008001;

use ExtUtils::MakeMaker 6.30;

my %WriteMakefileArgs = (
    ABSTRACT => "Mark some code or subs as deprecated",
    AUTHOR => "justnoxx",
    BUILD_REQUIRES => {},
    CONFIGURE_REQUIRES => {
        "ExtUtils::MakeMaker" => "6.30",
    },
    DISTNAME => "deprecated",
    LICENSE => "perl",
    NAME => "deprecated",
    PREREQ_PM => {
        "POSIX" =>  0,
        "Carp"  =>  0
    },
    VERSION_FROM => "lib/deprecated.pm",
    # test => {
    #     "TESTS" => "t/*.t"
    # },
    dist  => {
        COMPRESS => 'gzip -9f',
        SUFFIX => 'gz',
    },
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
    my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
    my $br = $WriteMakefileArgs{BUILD_REQUIRES};
    for my $mod ( keys %$tr ) {
        if ( exists $br->{$mod} ) {
            $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
        }
        else {
            $br->{$mod} = $tr->{$mod};
        }
    }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
    my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
    my $pp = $WriteMakefileArgs{PREREQ_PM};
    for my $mod ( keys %$br ) {
        if ( exists $pp->{$mod} ) {
            $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
        }
        else {
            $pp->{$mod} = $br->{$mod};
        }
    }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES} unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

# if so, ExtUtils::MakeMaker supports META_MERGE tag
if ($ExtUtils::MakeMaker::VERSION >= 6.46) {
    $WriteMakefileArgs{META_MERGE} = {
        "meta-spec" => { version => 2 },
        resources => {
            repository => {
                type    => 'git',
                url     => 'https://github.com/justnoxx/deprecated.git',
                web     => 'https://github.com/justnoxx/deprecated',
            },
        },
    };
}

WriteMakefile(%WriteMakefileArgs);
