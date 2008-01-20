#!/usr/bin/perl

package CBCommon;

use Config;
use Cwd 'abs_path';

our %opts = (
    VERSION           => '1.1.0',

    PREREQ_PM         => {},

    AUTHOR         => 'Sherm Pendley <camelbones@dot-app.org>',

    XSOPT           => "-typemap /Library/Frameworks/CamelBones.framework/Resources/typemap",

    LIBS              => [ '-lobjc' ],
    INC               => ($ENV{'GNUSTEP_ROOT'} ne '') ?
             "-xobjective-c -Wno-import -I$ENV{'GNUSTEP_SYSTEM_ROOT'}/Library/Headers -I$ENV{'GNUSTEP_LOCAL_ROOT'}/Library/Headers -DGNUSTEP -fconstant-string-class=NSConstantString " :
             "-ObjC ",
    dynamic_lib         => {
                        'OTHERLDFLAGS' =>
                            ($ENV{'GNUSTEP_ROOT'} ne '') ?
                            " -L$ENV{'GNUSTEP_SYSTEM_ROOT'}/Library/Libraries -L$ENV{'GNUSTEP_LOCAL_ROOT'}/Library/Libraries -lgnustep-base -lgnustep-gui -lCamelBones " :
                            " -framework Foundation -framework AppKit -framework CamelBones -lobjc "
                        },
);

if ($ENV{'CFLAGS'}) {
    $opts{'INC'} .= $ENV{'CFLAGS'};
}
if ($ENV{'LDFLAGS'}) {
    $opts{'dynamic_lib'}->{'OTHERLDFLAGS'} .= $ENV{'LDFLAGS'};
};

1;
