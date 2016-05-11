####################################################################################################################################
# FileTest.pm - Functions for manipulating files in the test directory
####################################################################################################################################
package pgBackRestTest::Common::FileTest;

####################################################################################################################################
# Perl includes
####################################################################################################################################
use strict;
use warnings FATAL => qw(all);
use Carp qw(confess);

use Exporter qw(import);
    our @EXPORT = qw();

use pgBackRest::Common::Log;

####################################################################################################################################
# testPathCreate
#
# Create a path in the test directory.
####################################################################################################################################
# sub filePathCreate
# {
#     # Assign function parameters, defaults, and log debug info
#     my
#     (
#         $strOperation,
#         $strVm,
#         $strPath,
#         $strMode,
#         $bIgnoreExists,
#         $bCreateParents
#     ) =
#         logDebugParam
#         (
#             __PACKAGE__ . '::filePathCreate', \@_,
#             {name => 'strPath', trace => true},
#             {name => 'strMode', default => '0750', trace => true},
#             {name => 'bIgnoreExists', default => false, trace => true},
#             {name => 'bCreateParents', default => false, trace => true}
#         );
#
#     if (!($bIgnoreExists && fileExists($strPath)))
#     {
#         # Attempt to create the directory
#         my $stryError;
#
#         if (!$bCreateParents && !fileExists(dirname($strPath)))
#         {
#             confess &log(ERROR, "unable to create ${strPath} because parent path does not exist", ERROR_PATH_CREATE);
#         }
#
#         make_path($strPath, {mode => oct($strMode), error => \$stryError});
#
#         # Throw any errrors that were returned
#         if (@$stryError)
#         {
#             my ($strErrorPath, $strErrorMessage) = %{@$stryError[0]};
#             confess &log(ERROR, "unable to create ${strPath}: ${strErrorMessage}", ERROR_PATH_CREATE);
#         }
#     }
#
#     # Return from function and log return values if any
#     return logDebugReturn
#     (
#         $strOperation
#     );
# }
#
# push @EXPORT, qw(filePathCreate);

1;
