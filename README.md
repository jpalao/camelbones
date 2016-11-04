# camelbones

Fork of Sherm Pendley's original CamelBones Project

CamelBones is a Cocoa/Perl bridge for Mac OS X. It allows easy access to the Cocoa API for Perl developers. It also allows easy, object-oriented access to an embedded Perl interpreter for Objective-C developers.

This project went unmaintained for about 5 years, this is what I have done:

- Updated to build with modern XCode versions
- Added x86_64 support. By default the project will build Universal binaries
- Better Objective-C 2.0 support
- Updated to libffi-3.2.1
- Remove dependencies of OS X system Perl
- Removed Plug-in Bundle from CamelBones.Framework
- Removed ExtLibs, PerlSDK directories, legacy Iceberg projects, PAR kit targets
- Add CoreGraphics support
- Edited some tests
- Updated Examples and ShuX
- Produced a Port file for macports installation (included)
- iOS support

# TODO

XCode templates still need to be converted from the older json format to the newer XML format

Also, these TODO items are from the the original author. https://sourceforge.net/p/camelbones/mailman/message/26651559/

- Add support for "fast iteration" of Perl collections.

- Expand support for returning values from Perl methods. Currently, all Perl methods are registered using a single IMP function. Methods that return struct values, or (on Intel) floating point values, need to use a different IMP function.

- Add support for .bridgesupport files on Leopard & newer. These files describe all non-OO functions and struct types, and resolve various ambiguities that runtime introspection cannot - for instance, whether an id* argument is returned by reference, or a C array of objects, or whether a variadic method uses a format string, a count variable, or flag value to determine the number of arguments.

- Refactor the circular dependency between the CamelBones XS modules and the CamelBones framework. This will involve moving many classes currently found in the framework, into the module. The goal is to remove the need for the module to link against the framework; the framework should only be needed by apps that use it to embed a Perl interpreter

# BUILD

### Optionally set configuration parameters

Default values are shown in the examples:

To set the type of build ('Debug' or 'Release') for CamelBones.framework
```
export CAMELBONES_BUILD_CONFIGURATION='Release'
```
To specify a different installation directory for CamelBones.framework (defaults to ~/Library/Frameworks)
```
export CAMELBONES_FRAMEWORK_INSTALL_PATH=~/Library/Frameworks
```
To overwrite the framework set this to 1. The process will die if the framework exists in the destination and this flag is not set
```
export OVERWRITE_CAMELBONES_FRAMEWORK=0
```
To change the architectures for the CamelBones framework and perl module *.bundle binaries. The default is to build a universal binary
```
export ARCHS='i386 x86_64'
```
To change the include directory for Perl
```
export PERL_INCLUDE_DIR= $Config{archlib}. "/CORE"
```
To change the flags used to link libperl.dylib. Defaults to the output of ExtUtils::Embed ldopts
```
export PERL_LINK_FLAGS= perl -MExtUtils::Embed -e ldopts
```

### Build and test

To build, test and install the Framework and build the Perl module 

```
% perl Makefile.PL
% make
% make test
% make install
```
Depending on your framework and Perl module installation directories you may need to sudo the commands. Please keep in mind that it is not generally a good idea to mess around w/ OS X System perl.

The Examples and ShuX directories of the distribution contain several applications to get started

Please report any problems so they can be corrected or better yet contribute your patches. Pull requests are welcome

Enjoy!!!
