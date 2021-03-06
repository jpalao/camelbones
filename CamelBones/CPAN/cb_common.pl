#!/usr/bin/perl

package CBCommon;

use Config;
use ExtUtils::Embed qw/ldopts/;

die "This version of CamelBones only works on macOS and iOS systems"
    if ( $^O !~ m/darwin/ );

=pod
 
=head1 cb_common.pl
 
This script builds the CamelBones Framework and associated perl XS extensions. 

The following ENV variables can be set to control its behavior.
 
=cut
 
=pod
 
=head2 PERL_INCLUDE_DIR
 
Absolute path to the directory containing the installed libperl.dylib
 
=cut

our $PERL_INCLUDE_DIR = $ENV{'LIBPERL_PATH'};

=pod
 
=head2 PERL_LINK_FLAGS
 
The linker flags to be used in the build. Defaults to:

perl -MExtUtils::Embed -e'print ldopts()'
 
=cut

our $PERL_LINK_FLAGS = $ENV{'PERL_LINK_FLAGS'};  

=pod
 
=head2 ARCHFLAGS
 
The compiler flags to be used in the build. Defaults to:

perl -MConfig -e'print $Config{'ccflags'}'
 
=cut

our $ARCHFLAGS = $ENV{'ARCHFLAGS'};

=pod
 
=head2 PERL_VERSION
 
The perl version that CamelBones should link to
 
=cut

our $PERL_VERSION = $ENV{'PERL_VERSION'};

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
 
=head2 CAMELBONES_PREFIX
 
TODO
 
=cut

our $CAMELBONES_PREFIX = $ENV{'CAMELBONES_PREFIX'};

=pod
 
=head2 CAMELBONES_VERSION
 
The verion of CamelBones to build
 
=cut

our $CAMELBONES_VERSION = $ENV{'CAMELBONES_VERSION'};

=pod
 
=head2 CAMELBONES_CPAN_DIR
 
Absolute path to CamelBones/CPAN
 
=cut

our $CAMELBONES_CPAN_DIR = $ENV{'CAMELBONES_CPAN_DIR'};

=pod
 
=head2 ARCHS
 
Architectures for this build, defaults to x86_64
 
=cut

our $ARCHS = $ENV{'ARCHS'};
if (!length $ARCHS) {
    $ARCHS = 'x86_64';
}

=pod
 
=head2 CAMELBONES_BUILD_CONFIGURATION
 
Either 'Debug' or 'Release'
 
=cut

our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};

$XCODE_BUILD_CONFIG .= "-$CAMELBONES_TARGET" if $CAMELBONES_TARGET !~ /macosx/;

###################################################################################

# TODO detach embedded libffi?
our $LIBFFIDIR = '../libffi-3.2.1';

print "\$CAMELBONES_CPAN_DIR: $CAMELBONES_CPAN_DIR\n";

my $abs_path_to_cpan_dir = $CAMELBONES_CPAN_DIR;

if (! defined $abs_path_to_cpan_dir) {
    if ($ENV{'CAMELBONES_CI'}) {
       $abs_path_to_cpan_dir = 
         "$CAMELBONES_PREFIX/perl-$PERL_VERSION/ext/CamelBones-$CAMELBONES_VERSION/";
    } else {
        $abs_path_to_cpan_dir = `pwd`;
        chomp $abs_path_to_cpan_dir;
    }
}

print "\$abs_path_to_cpan_dir: $abs_path_to_cpan_dir\n";

our $CAMELBONES_FRAMEWORK = 'CamelBones.framework';

my $perl_link_flags = ldopts();
print "\$perl_link_flags: $perl_link_flags\n";
chomp $perl_link_flags;

if (!defined $ARCHFLAGS || !length $ARCHFLAGS) {
    $ARCHFLAGS = $Config{'ccflags'};
    chomp $ARCHFLAGS;
}

if ($ENV{'CAMELBONES_CI'}) {
    $ARCHFLAGS .= "$perl_link_flags -ObjC -lobjc "
} else {
    $ARCHFLAGS .= " -L$PERL_INCLUDE_DIR -I$PERL_INCLUDE_DIR -ObjC -lobjc " 
}

# remove the arch switches to be passed to the linker
# $perl_link_flags =~ s/\-arch[ ]*\w*//g;
# 
# $PERL_LINK_FLAGS = $perl_link_flags
#     if (!defined $PERL_LINK_FLAGS || !length $PERL_LINK_FLAGS);
    
#$ARCHFLAGS .= " " . $PERL_LINK_FLAGS;

$PERL_INCLUDE_DIR = $Config{archlib}. "/CORE"
    if (!defined $PERL_INCLUDE_DIR || !length $PERL_INCLUDE_DIR);

$XCODE_BUILD_CONFIG = "Release"
    if (!defined $XCODE_BUILD_CONFIG || !length $XCODE_BUILD_CONFIG);

my $CamelBonesPath;

if ($ENV{CAMELBONES_CI}) {
    $CamelBonesPath = "$CAMELBONES_PREFIX/camelbones/CamelBones";
} else {
    $CamelBonesPath = "$abs_path_to_cpan_dir/..";
}

$CamelBonesPath .= "/Build/Products/$XCODE_BUILD_CONFIG";
    
our %opts = (
    VERSION           => $CAMELBONES_VERSION,
    CCFLAGS           => "$ARCHFLAGS -Wall",
    PREREQ_PM         => {},

    AUTHOR            => 'Sherm Pendley <sherm.pendley@gmail.com>',

    #XSOPT             => "-typemap $CAMELBONES_CPAN_DIR/typemap",
    XSOPT             => "-typemap $CAMELBONES_PREFIX/perl-$PERL_VERSION/ext/CamelBones-$CAMELBONES_VERSION/typemap",

    LIBS              => [ '-lobjc'],
    INC               => "-F$CamelBonesPath ",
    dynamic_lib       => {
                        'OTHERLDFLAGS' =>
                            "$ARCHFLAGS -framework Foundation " .
                            "-framework CamelBones -F$CamelBonesPath " . 
                            "-Wl,-rpath,$CamelBonesPath"
                        },
);

1;
