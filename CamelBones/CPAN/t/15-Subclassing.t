package CBSubclass;

use Test;

BEGIN { plan tests => 4 };
use CamelBones qw(:All);
use CamelBones::Tests;

# First define a subclass of an Objective-C class and override
# some of the parent's methods

class CBSubclass {
    super => 'CBSuper',
};

sub setInt : Selector(setInt:) ArgTypes(l) {
    my ($self, $int) = @_;
    return $self->SUPER::setInt($int);
}

sub intValue : Selector(intValue) ReturnType(l) {
    my ($self) = @_;
    return $self->SUPER::intValue();
}

sub floatValue : Selector(floatValue) ReturnType(d) {
    my ($self) = @_;
    return $self->SUPER::floatValue();
}

# Now test the overridden methods

# Disable non pointer isa obj-c runtimes, needed on iOS arm64/macOS x86_64 
# my $testNumber = CBSubclass->alloc->init;
my $testNumber = CBSubclass->allocWithZone(0)->init;

# Can we create a number?
if (defined $testNumber) {
    ok(1);
} else {
    ok(0);
}

$testNumber->setInt(5);
ok(2);

# It should be able to return a doubled int
if ($testNumber->intValue() == 5) {
    ok(3);
} else {
    ok(0);
}

# It should also be able to return a reasonable float
if ( abs ($testNumber->floatValue() - 5.0) < 0.00001 ) {
    ok(4);
} else {
    ok(0);
}

1;
