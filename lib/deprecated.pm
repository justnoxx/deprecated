package deprecated;

use Carp;

our $VERSION = 0.01;

sub import {
    my ($package) = @_;

    my $callpack = caller;
    my $msg = $callpack . ' is deprecated!';

    carp $msg;
}

sub subs {
    my ($class, @subs) = @_;

    my $callpack = $class;
    if (@subs) {
        for my $subname (@subs) {
            my $callsub = *{"${callpack}::$subname"}{CODE};
            print "$subname redefining\n";

            *{"${callpack}::$subname"} = sub {
                carp "subroutine $subname is deprecated!";
                $callsub->(@_);
            };
        }
    }
}

1;

__END__

=head1 NAME

deprecated

=head1 DESCRIPTION

Perl pragma for mark subrotines and modules as deprecated.

    use deprecated;

Enables the pragma, and you will see on module import warning message:

    OldPackage is deprecated! at OldPackage.pm line n.

To deprecate subs you should use subs sub.

    deptecated::subs('OldPackage', qw/oldfunction1 oldfunction2 oldfunction3/);

If you'll try to call OldPackage::oldfunction1, for example, you will get warning:

    subroutine oldfunction1 is deprecated! at script.pl line 12.

=cut
