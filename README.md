# camelbones

Fork of Sherm Pendley's original CamelBones Project

CamelBones is a Cocoa/Perl bridge for Mac OS X. It allows easy access to the Cocoa API for Perl developers. It also allows easy, object-oriented access to an embedded Perl interpreter for Objective-C developers.

As of April 2016, this project had been unmaintained for about 5 years, I decided to give this project a go in order to modernize it a bit:

- Added x86_64 support. By default the project will build Universal binaries
- Better Objective-C 2.0 support
- Updated to libffi-3.2.1
- Remove dependencies of OS X system Perl. Removed Plug-in Bundle from CamelBones.Framework
- Removed ExtLibs, PerlSDK directories, legacy Iceberg projects, PAR kit targets
- Add CGPoint, CGRect, CGSize type support
- Edited some tests

# TODO

These TODO items are from the the original author. https://sourceforge.net/p/camelbones/mailman/message/26651559/

- Add support for "fast iteration" of Perl collections.

- Expand support for returning values from Perl methods. Currently, all Perl methods are registered using a single IMP function. Methods that return struct values, or (on Intel) floating point values, need to use a different IMP function.

- Add support for .bridgesupport files on Leopard & newer. These files describe all non-OO functions and struct types, and resolve various ambiguities that runtime introspection cannot - for instance, whether an id* argument is returned by reference, or a C array of objects, or whether a variadic method uses a format string, a count variable, or flag value to determine the number of arguments.

- Refactor the circular dependency between the CamelBones XS modules and the CamelBones framework. This will involve moving many classes currently found in the framework, into the module. The goal is to remove the need for the module to link against the framework; the framework should only be needed by apps that use it to embed a Perl interpreter

# BUILD

0. Optionally have an environmental variable export the kind of build ('Debug' or 'Release'):
```
export CAMELBONES_BUILD_CONFIGURATION='Debug'
```

1. Build and test the traditional way:

```
% perl Makefile.PL
% make
% make test
```

This will build the CamelBones framework and the dynamic bundles

Note: You may need to edit the CCFLAGS and OTHERLDFLAGS for your target architecture in cb_common.pl and/or Makefile.PL if you do not wish to build a universal i386/x86_64 module.

All tests should pass. You should also be able to build and use all the native applications in the Examples directory of the distribution, except for those requiring a PAR kit. I haven't looked into that yet

Please report any problems so they can be corrected or better yet contribute your patches. Pull requests are welcome

Enjoy!!!
