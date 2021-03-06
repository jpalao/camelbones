# -*- Mode: cperl -*-

use Config;
use Test;
BEGIN { plan tests => 13; }

package PerlObject;
use CamelBones qw(:All);
class 'PerlObject';

sub sayOK : Selector(sayOK:) ArgTypes(i) {
    my ($this, $arg) = @_;
    Test::ok($arg);
}

sub initNewPerlObject : Selector(initNewPerlObject) ArgTypes() ReturnType(@) {
    my $self = shift;
    $self = $self->SUPER::init() if ($Config{archname} =~ /darwin-ios/);
    return $self;
}

package PerlObjectToo;
use CamelBones qw(:All);
class PerlObjectToo {'super' => 'PerlObject'} ;


package PerlObjectThree;
use CamelBones qw(:All);
class PerlObjectThree {
    'super' => 'PerlObject',
    'properties' => [ 'foo', 'bar', 'baz' ],
};

package PerlObjectFour;
use CamelBones qw(:All);
class PerlObjectFour {
    'super' => 'PerlObject',
    'properties' => {
        'foo' => 'NSObject',
        'bar' => undef,
    },
};

package main;

my $perlObject = PerlObject->alloc()->initNewPerlObject();
$perlObject->sayOK(1);

# Check that Perl method is correctly registered
if ($perlObject->can('sayOK')) {
    $perlObject->sayOK(2);
} else {
    $perlObject->sayOK(0);
}

# Verify that bogus method returns false
if ($perlObject->can('bogus')) {
    $perlObject->sayOK(0);
} else {
    $perlObject->sayOK(3);
}


# Check for inheritance
$perlObject = PerlObjectToo->alloc()->initNewPerlObject();
$perlObject->sayOK(4);



# Test properties
$perlObject = PerlObjectThree->alloc()->initNewPerlObject();
$perlObject->sayOK(5);


# Do accessors exist?
if ($perlObject->can('foo')) {
    $perlObject->sayOK(6);
} else {
    $perlObject->sayOK(0);
}
if ($perlObject->can('setBar')) {
    $perlObject->sayOK(7);
} else {
    $perlObject->sayOK(0);
}


# Test properties as hash ref
$perlObject = PerlObjectFour->alloc()->initNewPerlObject();
$perlObject->sayOK(8);


# Do accessors exist?
if ($perlObject->can('foo')) {
    $perlObject->sayOK(9);
} else {
    $perlObject->sayOK(0);
}
if ($perlObject->can('setBar')) {
    $perlObject->sayOK(10);
} else {
    $perlObject->sayOK(0);
}

# this one should not exist
$perlObject = PerlObject->alloc()->initNewPerlObject();
if ($perlObject->can('foo')) {
    $perlObject->sayOK(0);
} else {
    $perlObject->sayOK(11);
}

# test using accessors
$perlObject = PerlObjectFour->alloc()->initNewPerlObject();

$perlObject->setBar("testA");
if ($perlObject->bar eq "testA") {
    $perlObject->sayOK(12);
} else {
    $perlObject->sayOK(0);
}

$perlObject->setBar(undef);
if (!defined $perlObject->bar) {
    $perlObject->sayOK(13);
} else {
    $perlObject->sayOK(0);
}

# Try to set/get a property

# $perlObject->setValue_forKey('Hello', 'foo');
# if ($perlObject->valueForKey('Hello') eq 'value') {
# 	$perlObject->sayOK(11);
# } else {
# 	$perlObject->sayOK(0);
# }

1;
