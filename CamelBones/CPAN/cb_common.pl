#!/usr/bin/perl

package CBCommon;

use Config;
use ExtUtils::Embed qw/ldopts/;
use Cwd qw/abs_path getcwd/;

die "This version of CamelBones only works on macOS and iOS systems"
    if ( $^O !~ m/darwin/ );

our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};
our $CAMELBONES_FRAMEWORK_INSTALL_PATH = $ENV{'CAMELBONES_FRAMEWORK_INSTALL_PATH'};
our $OVERWRITE_CAMELBONES_FRAMEWORK = $ENV{'OVERWRITE_CAMELBONES_FRAMEWORK'};
our $INSTALL_CAMELBONES_FRAMEWORK = $ENV{'INSTALL_CAMELBONES_FRAMEWORK'};
our $LIBFFIDIR = '../libffi-3.2.1';
our $CAMELBONES_FRAMEWORK = 'CamelBones.framework';
our $ARCHS = $ENV{'ARCHS'};
our $PERL_INCLUDE_DIR = $ENV{'PERL_INCLUDE_DIR'};
our $PERL_LINK_FLAGS = $ENV{'PERL_LINK_FLAGS'};  
our $ARCHFLAGS = "-v -arch arm64 -miphoneos-version-min=8.0 -isysroot/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk -fno-common -pipe -Os -fno-strict-aliasing -fstack-protector-strong -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include  -I/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/include  -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib -Wl,-headerpad_max_install_names -fstack-protector-strong -ObjC -lobjc -L$PERL_INCLUDE_DIR -Wall -O3  ";


my $abs_path_to_cwd = getcwd();

my $down = "..";
if ($abs_path_to_cwd =~ /AppKit|Foundation|Tests/) {
    $down .= "/.."
}

my $perl_link_flags = ldopts();
chomp $perl_link_flags;

if (!length $ARCHFLAGS) {
    $ARCHFLAGS = '-arch i386 -arch x86_64';
}

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

my $CamelBonesPath = "$abs_path_to_cwd/$down/Build/Products/$XCODE_BUILD_CONFIG";

my $CamelBones = "$CamelBonesPath/$CAMELBONES_FRAMEWORK";

my $user_dir = $ENV{"HOME"};

$CAMELBONES_FRAMEWORK_INSTALL_PATH =~ s/~/$user_dir/;

if (! -e $CAMELBONES_FRAMEWORK_INSTALL_PATH) {
    my $framework_install_dir_create =
      system ('mkdir', '-p', $CAMELBONES_FRAMEWORK_INSTALL_PATH );
    die ("Could not create framework install directory:" .
        "$CAMELBONES_FRAMEWORK_INSTALL_PATH \nResult: $framework_install_dir_create")
      if ($framework_install_dir_create);
}

my $FrameworkInstallPath = abs_path($CAMELBONES_FRAMEWORK_INSTALL_PATH);

die "Error, cannot create framework installation directory: " . $FrameworkInstallPath
    if (!length $FrameworkInstallPath);

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
                            "-F$FrameworkInstallPath -Wl,-rpath,$CamelBonesPath"
                        },
);

1;
