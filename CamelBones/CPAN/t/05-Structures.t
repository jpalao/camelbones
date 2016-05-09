use Test::More tests => 56;
use Data::Dumper;

BEGIN {
    $|++;
#    plan tests => 56;
};

sub fpeq {
    my ($a, $b) = @_;
    ($a == $b) and return 1;
    if ($a < $b) {
        return (($b - $a) < 0.0001) ? 1 : 0;
    } else {
        return (($a - $b) < 0.0001) ? 1 : 0;
    }
}

use CamelBones qw(:All);
require_ok( 'CamelBones::Tests' );
#ok(1, "use CamelBones::Tests");

my $tester = CBStructureTests->alloc()->init();
ok(defined $tester, "Init OK");

#The NS and CG geometry types are the same structures
ok(ref $tester->point() eq 'CamelBones::NSPoint' || ref $tester->point() eq 'CamelBones::CGPoint', "CamelBones::NSPoint");
ok(ref $tester->range() eq 'CamelBones::NSRange', "CamelBones::NSRange");
ok(ref $tester->rect() eq 'CamelBones::NSRect' || ref $tester->rect() eq 'CamelBones::CGRect', "CamelBones::NSRect");
ok(ref $tester->size() eq 'CamelBones::NSSize' || ref $tester->size() eq 'CamelBones::CGSize', "'CamelBones::NSSize'");

ok(fpeq($tester->pointX(), 0.0), "tester->pointX() == 0.0");
ok(fpeq($tester->pointY(), 0.0), "tester->pointY() == 0.0");

$tester->setPoint({'x' => 5.0, 'y' => 10.0});
ok(fpeq($tester->pointX(), 5.0), "tester->pointX() == 5.0");
ok(fpeq($tester->pointY(), 10.0), "tester->pointY() == 10.0");
ok(fpeq($tester->point()->getX(), 5.0), "tester->point()->getX() == 5.0");
ok(fpeq($tester->point()->getY(), 10.0), "tester->point()->getY() == 10.0");

# diag( "$tester->point()->getX():", Dumper($tester->point()->getX()) )

$tester->setPoint([25.0, 20.0]);
ok(fpeq($tester->pointX(), 25.0), "tester->pointX() == 25.0");
ok(fpeq($tester->pointY(), 20.0), "tester->pointY() == 20.0");
ok(fpeq($tester->point()->getX(), 25.0), "tester->point()->getX() == 25.0");
ok(fpeq($tester->point()->getY(), 20.0), "tester->point()->getY() == 20.0");

ok(($tester->rangeLocation() == 0), );
ok(($tester->rangeLength() == 0), );

$tester->setRange({'location' => 5, 'length' => 10});
ok(($tester->rangeLocation() == 5), );
ok(($tester->rangeLength() == 10), );
ok(($tester->range()->getLocation() == 5), );
ok(($tester->range()->getLength() == 10), );
$tester->setRange([15, 20]);
ok(($tester->rangeLocation() == 15), );
ok(($tester->rangeLength() == 20), );
ok(($tester->range()->getLocation() == 15), );
ok(($tester->range()->getLength() == 20), );

ok(fpeq($tester->rectX(), 0.0), "tester->rectX() == 0.0");
ok(fpeq($tester->rectY(), 0.0), "tester->rectY() == 0.0");
ok(fpeq($tester->rectWidth(), 0.0), "tester->rectWidth() == 0.0");
ok(fpeq($tester->rectHeight(), 0.0), "tester->rectHeight() == 0.0");

$tester->setRect({'x' => 5.0, 'y' => 10.0, 'width' => 15.0, 'height' => 20.0});
ok(fpeq($tester->rectX(), 5.0), "tester->rectX() == 5.0");
ok(fpeq($tester->rectY(), 10.0), "tester->rectY() == 10.0");

ok(fpeq($tester->rectWidth(), 15.0), "tester->rectWidth() == 15.0");
ok(fpeq($tester->rectHeight(), 20.0), "tester->rectHeight() == 20.0") or
        diag("tester->rectHeight():", $tester->rectHeight());

ok(fpeq($tester->rect()->getX(), 5.0), "tester->rect()->getX() == 5.0");
ok(fpeq($tester->rect()->getY(), 10.0), "tester->rect()->getY() == 10.0");
ok(fpeq($tester->rect()->getWidth(), 15.0), "tester->rect()->getWidth() == 15.0");
ok(fpeq($tester->rect()->getHeight(), 20.0), "tester->rect()->getHeight() == 20.0");

$tester->setRect([25.0, 30.0, 35.0, 40.0]);
ok(fpeq($tester->rectX(), 25.0), "tester->rectX() == 25.0");
ok(fpeq($tester->rectY(), 30.0), "tester->rectY() == 30.0");
ok(fpeq($tester->rectWidth(), 35.0), "tester->rectWidth() == 35.0");
ok(fpeq($tester->rectHeight(), 40.0), "tester->rectHeight() == 40.0");

ok(fpeq($tester->rect()->getX(), 25.0), "tester->rect()->getX() == 25.0");
ok(fpeq($tester->rect()->getY(), 30.0), "tester->rect()->getY() == 30.0");
ok(fpeq($tester->rect()->getWidth(), 35.0), "tester->rect()->getWidth() == 35.0");
ok(fpeq($tester->rect()->getHeight(), 40.0), "tester->rect()->getHeight() == 40.0");

ok(fpeq($tester->sizeWidth(), 0.0), "tester->sizeWidth() == 0.0");
ok(fpeq($tester->sizeHeight(), 0.0), "tester->sizeHeight() == 0.0");

$tester->setSize({'width' => 5.0, 'height' => 10.0});
ok(fpeq($tester->sizeWidth(), 5.0), "tester->sizeWidth() == 5.0");
ok(fpeq($tester->sizeHeight(), 10.0), "tester->sizeHeight() == 10.0");
ok(fpeq($tester->size()->getWidth(), 5.0), "tester->size()->getWidth() == 5.0");
ok(fpeq($tester->size()->getHeight(), 10.0), "tester->size()->getHeight() == 10.0");

$tester->setSize([15.0, 20.0]);
ok(fpeq($tester->sizeWidth(), 15.0), "tester->sizeWidth() == 15.0");
ok(fpeq($tester->sizeHeight(), 20.0), "tester->sizeHeight() == 20.0");
ok(fpeq($tester->size()->getWidth(), 15.0), "tester->size()->getWidth() == 15.0");
ok(fpeq($tester->size()->getHeight(), 20.0), "tester->size()->getHeight() == 20.0");
