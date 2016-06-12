#!/usr/bin/perl

package CBCommon;

use Config;
use Cwd qw/abs_path getcwd/;

die "This version of CamelBones only works on Darwin Mac OS X systems"
    if ( $^O !~ m/darwin/ );

our $XCODE_BUILD_CONFIG = $ENV{'CAMELBONES_BUILD_CONFIGURATION'};
our $CAMELBONES_FRAMEWORK_INSTALL_PATH = $ENV{'CAMELBONES_FRAMEWORK_INSTALL_PATH'};
our $OVERWRITE_CAMELBONES_FRAMEWORK = $ENV{'OVERWRITE_CAMELBONES_FRAMEWORK'};
our $LIBFFIDIR = '../libffi-3.2.1';
our $CAMELBONES_FRAMEWORK = 'CamelBones.framework';
our $ARCHFLAGS = $ENV{'ARCHFLAGS'};
our $PERL_INCLUDE_DIR = $ENV{'PERL_INCLUDE_DIR'};
our $PERL_LIB_DIR = $ENV{'PERL_LIB_DIR'};    

my $abs_path_to_cwd = getcwd();

my $down = "..";
if ($abs_path_to_cwd =~ /AppKit|Foundation|Tests/) {
    $down .= "/.."
}

$PERL_LIB_DIR = $Config{archlib}. "/CORE"
    if (!defined $PERL_LIB_DIR || !length $PERL_LIB_DIR);

$PERL_INCLUDE_DIR = $Config{archlib}. "/CORE"
    if (!defined $PERL_INCLUDE_DIR || !length $PERL_INCLUDE_DIR);

$XCODE_BUILD_CONFIG = "Debug"
    if (!defined $XCODE_BUILD_CONFIG || !length $XCODE_BUILD_CONFIG);

$CAMELBONES_FRAMEWORK_INSTALL_PATH = "~/Library/Frameworks"
    if (!defined $CAMELBONES_FRAMEWORK_INSTALL_PATH || 
    	  !length $CAMELBONES_FRAMEWORK_INSTALL_PATH);
    
$OVERWRITE_CAMELBONES_FRAMEWORK = 0
    if $OVERWRITE_CAMELBONES_FRAMEWORK != 1;   
    
$ARCHFLAGS = '-arch i386 -arch x86_64'
    if (!defined $ARCHFLAGS || !length $ARCHFLAGS);

my $CamelBonesPath = "$abs_path_to_cwd/$down/Build/Products/$XCODE_BUILD_CONFIG";

my $CamelBones = "$CamelBonesPath/$CAMELBONES_FRAMEWORK";

my $user_dir = $ENV{"HOME"};

$CAMELBONES_FRAMEWORK_INSTALL_PATH =~ s/~/$user_dir/;

if (! -e $CAMELBONES_FRAMEWORK_INSTALL_PATH) {
    my $framework_install_dir_create = 
    	system ('mkdir', '-p', $CAMELBONES_FRAMEWORK_INSTALL_PATH );
    die ("Could not create framework install directory: " .
    	$CAMELBONES_FRAMEWORK_INSTALL_PATH . "\nResult: $framework_install_dir_create")
    	if ($framework_install_result);
}

my $FrameworkInstallPath = abs_path($CAMELBONES_FRAMEWORK_INSTALL_PATH);

die "Error, cannot create framework installation directory: " . $FrameworkInstallPath
    if (!length $FrameworkInstallPath);
    
our %opts = (
    VERSION           => '1.2.0',
    CCFLAGS           => "$ARCHFLAGS -Wall",
    PREREQ_PM         => {},

    AUTHOR            => 'Sherm Pendley <sherm.pendley@gmail.com>',

    XSOPT             => "-typemap $CamelBones/Resources/typemap",

    LIBS              => [ '-lobjc'],
    INC               => "-F$CamelBonesPath ",
    dynamic_lib       => {
                        'OTHERLDFLAGS' =>
                            "$ARCHFLAGS -framework Foundation -framework AppKit -framework CamelBones -F/System/Library/Frameworks -F$FrameworkInstallPath"
                        },
);

1;
