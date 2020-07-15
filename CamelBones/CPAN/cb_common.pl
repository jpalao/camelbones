#!/usr/bin/perl

package CBCommon;

use Config;
use ExtUtils::Embed qw/ldopts/;

die "This version of CamelBones only works on macOS and iOS systems"
    if ( $^O !~ m/darwin/ );

our $ARCHS = $ENV{'ARCHS'};
our $CAMELBONES_PREFIX = $ENV{'CAMELBONES_PREFIX'};
our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};
our $CAMELBONES_FRAMEWORK_INSTALL_PATH = $ENV{'CAMELBONES_FRAMEWORK_INSTALL_PATH'};
our $OVERWRITE_CAMELBONES_FRAMEWORK = $ENV{'OVERWRITE_CAMELBONES_FRAMEWORK'};
our $INSTALL_CAMELBONES_FRAMEWORK = $ENV{'INSTALL_CAMELBONES_FRAMEWORK'};
our $PERL_INCLUDE_DIR = $ENV{'PERL_INCLUDE_DIR'};
our $PERL_LINK_FLAGS = $ENV{'PERL_LINK_FLAGS'};  
our $ARCHFLAGS = $ENV{'ARCHFLAGS'};

my $abs_path_to_cwd = "$CAMELBONES_PREFIX/perl-5.32.0/ext/CamelBones-1.2.0/";

our $LIBFFIDIR = '../libffi-3.2.1';
our $CAMELBONES_FRAMEWORK = 'CamelBones.framework';

my $down = "..";
if ($abs_path_to_cwd =~ /AppKit|Foundation|Tests/) {
    $down .= "/.."
}

my $perl_link_flags = ldopts();
chomp $perl_link_flags;

if (!length $ARCHFLAGS) {
    $ARCHFLAGS = $Config{'ccflags'};
    chomp $ARCHFLAGS;
}

$ARCHFLAGS .= " -L$PERL_INCLUDE_DIR  -ObjC -lobjc ";

if (!length $ARCHS) {
    $ARCHS = 'i386 x86_64';
}

# remove the arch switches to be passed to the linker
$perl_link_flags =~ s/\-arch[ ]*\w*//g;

$PERL_LINK_FLAGS = $perl_link_flags
    if (!defined $PERL_LINK_FLAGS || !length $PERL_LINK_FLAGS);
    
#$ARCHFLAGS .= " " . $PERL_LINK_FLAGS;

$PERL_INCLUDE_DIR = $Config{archlib}. "/CORE"
    if (!defined $PERL_INCLUDE_DIR || !length $PERL_INCLUDE_DIR);

$INSTALL_CAMELBONES_FRAMEWORK = 1
    if (!defined $INSTALL_CAMELBONES_FRAMEWORK || !length $INSTALL_CAMELBONES_FRAMEWORK);

$XCODE_BUILD_CONFIG = "Release"
    if (!defined $XCODE_BUILD_CONFIG || !length $XCODE_BUILD_CONFIG);

$CAMELBONES_FRAMEWORK_INSTALL_PATH = "~/Library/Frameworks"
    if (!defined $CAMELBONES_FRAMEWORK_INSTALL_PATH ||
        !length $CAMELBONES_FRAMEWORK_INSTALL_PATH);
    
$OVERWRITE_CAMELBONES_FRAMEWORK = 0
    if $OVERWRITE_CAMELBONES_FRAMEWORK != 1;

my $CamelBonesPath = "$CAMELBONES_PREFIX/camelbones/CamelBones/Build/Products/$XCODE_BUILD_CONFIG";

my $CamelBones = "$CamelBonesPath/$CAMELBONES_FRAMEWORK";

my $user_dir = $ENV{"HOME"};

my $FrameworkInstallPath = "$CAMELBONES_PREFIX/local/Library/Frameworks";

our %opts = (
    VERSION           => '1.2.0',
    CCFLAGS           => "$ARCHFLAGS -Wall",
    PREREQ_PM         => {},

    AUTHOR            => 'Sherm Pendley <sherm.pendley@gmail.com>',

    XSOPT             => "-typemap $abs_path_to_cwd/typemap",

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
