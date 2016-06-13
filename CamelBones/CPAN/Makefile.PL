use 5.006;

my %local_opts;
BEGIN {
    require "./cb_common.pl";
    %local_opts = (
        'NAME' => 'CamelBones',
        'DIR' => [ 'AppKit', 'Foundation', 'Tests' ],
        'XS' => { 'CamelBones.xs' => 'CamelBones.m' },
    );
    for (keys %CBCommon::opts) {
	$local_opts{$_} = $CBCommon::opts{$_};
    }
}

print "Building ". $CBCommon::LIBFFIDIR . "...\n";

chdir $CBCommon::LIBFFIDIR;   

my $archs = $CBCommon::ARCHFLAGS;

$archs =~ s/\-arch([ ]*\w*)/$1/g;

my $lib_ffi_build_result = system (
    "xcodebuild",
    'ARCHS='.$archs,
    'ONLY_ACTIVE_ARCH=NO',    
    "-target",
    "libffi-Mac-static",
    "-configuration",
    $CBCommon::XCODE_BUILD_CONFIG
);

chdir "..";

die ("Error: libffi.a could not be built: $lib_ffi_build_result\n")
    if $lib_ffi_build_result;

print "Building ". $CBCommon::CAMELBONES_FRAMEWORK . "...\n";

my @camelbones_framework_build_cmd = (
    "xcodebuild",
    'ARCHS='.$archs,
    'ONLY_ACTIVE_ARCH=NO',
    'USER_HEADER_SEARCH_PATHS=' . $CBCommon::PERL_INCLUDE_DIR,
    'OTHER_LDFLAGS=' . $CBCommon::PERL_LINK_FLAGS . 
    	' -Wl,-headerpad_max_install_names -Wl,-no_compact_unwind',
    "-target",
    $CBCommon::CAMELBONES_FRAMEWORK,
    "-configuration", $CBCommon::XCODE_BUILD_CONFIG
);

print "CamelBones.framework build command: \n";

for my $arg (@camelbones_framework_build_cmd) {
    print $arg. " ";
}

print "\n";

my $camelbones_framework_build_result = system (
    @camelbones_framework_build_cmd
);

die ("CamelBones framework build error. Result: $camelbones_framework_build_result\n")
    if $camelbones_framework_build_result;

die "CamelBones.framework exists already in " . 
	$CBCommon::CAMELBONES_FRAMEWORK_INSTALL_PATH
    	if (( -e $CBCommon::CAMELBONES_FRAMEWORK_INSTALL_PATH . '/' . 
    		$CBCommon::CAMELBONES_FRAMEWORK) &&
	    		(!$CBCommon::OVERWRITE_CAMELBONES_FRAMEWORK));

my $framework_install_result = 
    system ('cp', '-Ra', "Build/Products/" . $CBCommon::XCODE_BUILD_CONFIG . '/' . 
    	$CBCommon::CAMELBONES_FRAMEWORK, $CBCommon::CAMELBONES_FRAMEWORK_INSTALL_PATH);

die ("Framework install error. Result: $framework_install_result\n")
    if ($framework_install_result);

chdir "CPAN";

use ExtUtils::MakeMaker;
WriteMakefile(
    %local_opts
);

# Add some required machinery to support .m files
package MY;
sub c_o {
    my $inherited = shift->SUPER::c_o(@_);
	$inherited !~ /^\.m\$(OBJ_EXT):$/ and $inherited .= <<'EOMESS';
.m$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.m
    
EOMESS
    $inherited;
}

sub xs_c {
    my $inherited = shift->SUPER::xs_c(@_);
    $inherited !~ /^\.xs\.m:$/ and $inherited .= <<'EOMESS';
.xs.m:
	$(PERLRUN) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) $*.xs > $*.xsm && $(MV) $*.xsm $*.m
    
EOMESS
    $inherited;
}

sub init_dirscan {
    my $self = shift;
    $self->SUPER::init_dirscan;
    
    foreach my $name ($self->lsdir($self->curdir)) {
        next unless $name =~ /\.m$/;
        push @{$self->{'C'}}, $name;
        $name =~ s/\.m$/$self->{'OBJ_EXT'}/;
        push @{$self->{'O_FILES'}}, $name;
    }
}

1;
