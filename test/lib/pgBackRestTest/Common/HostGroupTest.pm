####################################################################################################################################
# HostGroupTest.pm - Encapsulate a group of docker containers for testing
####################################################################################################################################
package pgBackRestTest::Common::HostGroupTest;

####################################################################################################################################
# Perl includes
####################################################################################################################################
use strict;
use warnings FATAL => qw(all);
use Carp qw(confess);

use Cwd qw(abs_path);
use Exporter qw(import);
    our @EXPORT = qw();
use File::Basename qw(dirname);

use lib dirname($0) . '/../lib';
use pgBackRest::Common::Log;
use pgBackRest::Common::String;

use pgBackRestTest::Common::ExecuteTest;

####################################################################################################################################
# Global host group variable
####################################################################################################################################
my $oHostGroup;

####################################################################################################################################
# new
####################################################################################################################################
sub new
{
    my $class = shift;          # Class name

    # Create the class hash
    my $self = {};
    bless $self, $class;

    # Assign function parameters, defaults, and log debug info
    my ($strOperation) = logDebugParam(__PACKAGE__ . '->new');

    # Return from function and log return values if any
    return logDebugReturn
    (
        $strOperation,
        {name => 'self', value => $self, trace => true}
    );
}

####################################################################################################################################
# hostAdd
####################################################################################################################################
sub hostAdd
{
    my $self = shift;

    # Assign function parameters, defaults, and log debug info
    my
    (
        $strOperation,
        $oHost
    ) =
        logDebugParam
        (
            __PACKAGE__ . '->hostAdd', \@_,
            {name => 'oHost'}
        );

    $self->{host}{$oHost->{strName}} = $oHost;

    $oHost->executeSimple("sh -c 'echo \"\" >> /etc/hosts\'", undef, 'root');
    $oHost->executeSimple("sh -c 'echo \"# Test Hosts\" >> /etc/hosts'", undef, 'root');

    # Iterate hosts to add IP mappings
    foreach my $strOtherHostName (sort(keys($self->{host})))
    {
        my $oOtherHost = $self->{host}{$strOtherHostName};

        # Add this host IP to all hosts
        $oOtherHost->executeSimple("sh -c 'echo \"$oHost->{strIP} $oHost->{strName}\" >> /etc/hosts'", undef, 'root');

        # Add all other host IPs to this host
        if ($strOtherHostName ne $oHost->{strName})
        {
            $oHost->executeSimple("sh -c 'echo \"$oOtherHost->{strIP} ${strOtherHostName}\" >> /etc/hosts'", undef, 'root');
        }
    }

    # Return from function and log return values if any
    return logDebugReturn($strOperation);
}

####################################################################################################################################
# hostGroupGet
#
# Get the global host group object.
####################################################################################################################################
sub hostGroupGet
{
    if (!defined($oHostGroup))
    {
        $oHostGroup = new pgBackRestTest::Common::HostGroupTest();
    }

    return $oHostGroup;
}

push @EXPORT, qw(hostGroupGet);

1;
