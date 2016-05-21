#!/usr/bin/perl

package CBCommon;

use Config;
use Cwd qw/abs_path getcwd/;

die "This version of CamelBones only works on Darwin Mac OS X systems"
    if ( $^O !~ m/darwin/ );

our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};
our $LIBFFIDIR = '../libffi-3.2.1';
our $CAMELBONES_FRAMEWORK = 'CamelBones.framework';

my $abs_path_to_cwd = getcwd();

my $down = "..";
if ($abs_path_to_cwd =~ /AppKit|Foundation|Tests/) {
    $down .= "/.."
}

$XCODE_BUILD_CONFIG = "Debug" if (!length $XCODE_BUILD_CONFIG);

my $CamelBonesPath = "$abs_path_to_cwd/$down/build/$XCODE_BUILD_CONFIG";

my $CamelBones = "$CamelBonesPath/$CAMELBONES_FRAMEWORK";

our %opts = (
    VERSION           => '1.2.0',
    CCFLAGS           => "-arch i386 -arch x86_64 -Wall",
    PREREQ_PM         => {},

    AUTHOR            => 'Sherm Pendley <sherm.pendley@gmail.com>',

    XSOPT             => "-typemap $CamelBones/Resources/typemap",

    LIBS              => [ '-lobjc'],
    INC               => "-F$CamelBonesPath ",
    dynamic_lib       => {
                        'OTHERLDFLAGS' =>
                            "-arch i386 -arch x86_64  -framework Foundation -framework AppKit -framework CamelBones -F/System/Library/Frameworks -F$CamelBonesPath "
                        },
);

1;
