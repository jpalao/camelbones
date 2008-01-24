#!/usr/bin/perl

package CBCommon;

use Config;
use Cwd 'abs_path';

our %opts = (
    VERSION           => '1.1.0',

    PREREQ_PM         => {},

    AUTHOR         => 'Sherm Pendley <camelbones@dot-app.org>',

    LIBS              => [ '-lobjc' ],
    INC               => ($ENV{'GNUSTEP_ROOT'} ne '') ?
             "-xobjective-c -Wno-import -I$ENV{'GNUSTEP_SYSTEM_ROOT'}/Library/Headers -I$ENV{'GNUSTEP_LOCAL_ROOT'}/Library/Headers -DGNUSTEP -fconstant-string-class=NSConstantString " :
             "-I/Applications/CamelBones/Perl/lib/perl5/5.10.0/darwin-thread-multi-2level/CORE -ObjC ",
    dynamic_lib         => {
                        'OTHERLDFLAGS' =>
                            ($ENV{'GNUSTEP_ROOT'} ne '') ?
                            " -L$ENV{'GNUSTEP_SYSTEM_ROOT'}/Library/Libraries -L$ENV{'GNUSTEP_LOCAL_ROOT'}/Library/Libraries -lgnustep-base -lgnustep-gui -lCamelBones " :
                            " -L/Applications/CamelBones/Perl/lib/perl5/5.10.0/darwin-thread-multi-2level/CORE -lperl -framework Foundation -framework AppKit -framework CamelBones -lobjc "
                        },
);

if ($ENV{'CFLAGS'}) {
    $opts{'INC'} .= $ENV{'CFLAGS'};
}
if ($ENV{'LDFLAGS'}) {
    $opts{'dynamic_lib'}->{'OTHERLDFLAGS'} .= $ENV{'LDFLAGS'};
};

1;
