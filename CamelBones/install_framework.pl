#!/bin/env perl

use strict;
use warnings;

=head2 INSTALL_CAMELBONES_FRAMEWORK
 
1 to install CamelBones.framework, 0 does not perform installation
 
=cut

our $INSTALL_CAMELBONES_FRAMEWORK = $ENV{'INSTALL_CAMELBONES_FRAMEWORK'};

=pod
 
=head2 CAMELBONES_FRAMEWORK_INSTALL_PATH
 
Location for CamelBones.framework installation
 
=cut

our $CAMELBONES_FRAMEWORK_INSTALL_PATH = $ENV{'CAMELBONES_FRAMEWORK_INSTALL_PATH'};

=pod
 
=head2 OVERWRITE_CAMELBONES_FRAMEWORK
 
When INSTALL_CAMELBONES_FRAMEWORK is set, overwrite CamelBones.framework if it exists
 
=cut

our $OVERWRITE_CAMELBONES_FRAMEWORK = $ENV{'OVERWRITE_CAMELBONES_FRAMEWORK'};

=pod

=head2 CAMELBONES_TARGET
 
The target of this build. One of:

=item 

macosx

=item

iphoneos

=item

iphonesimulator

=item

appletvos

=item

appletvsimulator

=item

watchos

=item

watchsimulator

Default is macosx

=cut

our $CAMELBONES_TARGET = $ENV{'CAMELBONES_TARGET'};

=pod
 
=head2 CAMELBONES_BUILD_CONFIGURATION
 
Either 'Debug' or 'Release'
 
=cut

our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};

$XCODE_BUILD_CONFIG .= "-$CAMELBONES_TARGET" if $CAMELBONES_TARGET !~ /macosx/;

############################################################

$INSTALL_CAMELBONES_FRAMEWORK = 1
    if (!defined $INSTALL_CAMELBONES_FRAMEWORK || 
        !length $INSTALL_CAMELBONES_FRAMEWORK);

$CAMELBONES_FRAMEWORK_INSTALL_PATH = $ENV{HOME}."/Library/Frameworks"
    if (!defined $CAMELBONES_FRAMEWORK_INSTALL_PATH ||
        !length $CAMELBONES_FRAMEWORK_INSTALL_PATH);
    
$OVERWRITE_CAMELBONES_FRAMEWORK = 0
    if (!$OVERWRITE_CAMELBONES_FRAMEWORK);

if (! -e $CAMELBONES_FRAMEWORK_INSTALL_PATH) {
    my $framework_install_dir_create =
      system ('mkdir', '-p', $CAMELBONES_FRAMEWORK_INSTALL_PATH );
    die ("Could not create framework install directory:" .
        "$CAMELBONES_FRAMEWORK_INSTALL_PATH \nResult: $framework_install_dir_create")
      if ($framework_install_dir_create);      
}

if ($INSTALL_CAMELBONES_FRAMEWORK && $OVERWRITE_CAMELBONES_FRAMEWORK) {
    print "Removing original installation\n";
    `rm -Rf $CAMELBONES_FRAMEWORK_INSTALL_PATH/CamelBones.framework`
}

if ($INSTALL_CAMELBONES_FRAMEWORK) {
    print "Installing CamelBones.framework ...\n";
    my $framework_location = "Build/Products/$XCODE_BUILD_CONFIG/CamelBones.framework";
    print `cp -vR "$framework_location" "$CAMELBONES_FRAMEWORK_INSTALL_PATH"`
}

