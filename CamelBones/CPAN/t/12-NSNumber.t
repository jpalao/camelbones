use Test;

BEGIN { plan tests => 3 };
use CamelBones qw(:All);

# Can we create a number?
my $testNumber = NSNumber->numberWithInt(5);
if (defined $testNumber) {
    ok(1);
} else {
    ok(0);
}

# It should be able to return an int
if ($testNumber->intValue() == 5) {
    ok(2);
} else {
    ok(0);
}

# It should also be able to return a reasonable float
if ( abs ($testNumber->floatValue() - 5.0) < 0.00001 ) {
    ok(3);
} else {
    ok(0);
}

1;
