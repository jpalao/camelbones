# camelbones

Fork of Sherm Pendley's original CamelBones Project

CamelBones is a Cocoa/Perl bridge for Mac OS X. It allows easy access to the Cocoa API for Perl developers. It also allows easy, object-oriented access to an embedded Perl interpreter for Objective-C developers.

As of April 2016, this project had been unmaintained for about 5 years, I decided to give this project some time in order to modernize it a bit:

- Added x86_64 support
- Objective-C 2.0 support
- Updated to libffi-3.2.1
- Eliminate dependency of OS X system Perl

# TODO

- The applications in the Example directories requiring a PAR kit are not working

These TODO items are from the the original author. https://sourceforge.net/p/camelbones/mailman/message/26651559/

- Support for  .bridgesupport files.

- Add support for "fast iteration" of Perl collections.

- Expand support for returning values from Perl methods. Currently, all Perl methods are registered using a single IMP function. Methods that return struct values, or (on Intel) floating point values, need to use a different IMP function.

- Add support for .bridgesupport files on Leopard & newer. These files describe all non-OO functions and struct types, and resolve various ambiguities that runtime introspection cannot - for instance, whether an id* argument is returned by reference, or a C array of objects, or whether a variadic method uses a format string, a count variable, or flag value to determine the number of arguments.

- Refactor the circular dependency between the CamelBones XS modules and the CamelBones framework. This will involve moving many classes currently found in the framework, into the module. The goal is to remove the need for the module to link against the framework; the framework should only be needed by apps that use it to embed a Perl interpreter

# BUILD

To build and test:

1. Open the XCode project file and build the Camelbones.framework

2. Change to the directory containing the Camelbones Perl Module:
% cd CPAN-camelbones   

3. Export the location of the directory containing the newly built Camelbones.framework:
% export CAMELBONES_PATH=/Your/Location/Build/Products/Debug

4. Build the Camelbones Perl Module:
% perl Makefile.PL
% make
% make test

All tests should pass. You should also be able to build and use all the native applications in the Examples directory of the distribution, except for those requiring a PAR kit. I haven't looked into that yet

Please report any problems so they can be corrected or better yet contribute your patches. Pull requests are welcome

5. Enjoy!!!
