#!/usr/bin/env sh

# BUILD #
export MACOSX_DEPLOYMENT_TARGET='10.9'
export ARCHS='x86_64'

# PERL #
export PERL_VERSION='5.33.7'
export LIBPERL_PATH=`perl -MConfig -e'print $Config{archlib}. "/CORE"'`

# CAMELBONES #
export CAMELBONES_VERSION='1.3.0'
export CAMELBONES_CI=
export CAMELBONES_PREFIX=`pwd`
export CAMELBONES_CPAN_DIR=`pwd`/CPAN
export CAMELBONES_BUILD_CONFIGURATION='Debug'
export CAMELBONES_TARGET='macosx'
export INSTALL_CAMELBONES_FRAMEWORK=1
export OVERWRITE_CAMELBONES_FRAMEWORK=1
export XCODE_SCHEME='macosx'

# $ xcodebuild -list
# Command line invocation:
#     /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -list
# 
# Information about project "libffi":
#     Targets:
#         libffi-iphoneos
#         libffi-macosx
#         libffi-iphonesimulator
# 
#     Build Configurations:
#         Debug
#         Release
# 
#     If no build configuration is specified and -scheme is not passed then "Release" is used.
# 
#     Schemes:
#         libffi-iphoneos
#         libffi-iphonesimulator
#         libffi-macosx

build_libffi() {
  pushd ./libffi-3.2.1
  xcodebuild -scheme libffi-"$CAMELBONES_TARGET"
  popd
}

build_libffi

#  CamelBones.framework
#  CamelBonesiOS.framework
#  CamelBonesiOS.framework simulator

xcodebuild  ARCHS="$ARCHS" PERL_INCLUDE_DIR="$PERL_INCLUDE_DIR" ONLY_ACTIVE_ARCH=NO \
 -allowProvisioningUpdates -scheme "$XCODE_SCHEME"

# if INSTALL_CAMELBONES_FRAMEWORK
perl -w ./install_framework.pl

cd CPAN
make distclean
perl Makefile.PL
make
make test

