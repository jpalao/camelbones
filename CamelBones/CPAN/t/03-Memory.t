use Test;
BEGIN { plan tests => 5 };

use CamelBones qw(:All);
ok(1);

use CamelBones::Tests;
ok(2);

my $data = NSMutableData->alloc()->initWithLength(16);
my $addr = $data->bytes();

#test for 64/32 bit intel perl
our $pack_template  = (pack 'P', -1 == 8) ? 'Q': 'I'; 

if ($pack_template eq 'Q') {
	CBPoke($addr, pack('Q', 0xdeadbeefdeadbeef), 8);
	
	my $val = unpack('Q', unpack('P8', pack('Q', $addr)));
	
	ok(($val == 0xdeadbeefdeadbeef) ? 3 : 0);
	
	my $point = NSMakePoint(5.0, 5.0);
	CBPoke($addr, $point);
	ok(4);
	
	my ($x, $y) = unpack('dd', unpack('P16', pack('Q', $addr)));
	ok(($x == 5 && $y == 5) ? 5 : 0);
}
else {
	CBPoke($addr, pack('I', 0xdeadbeef), 4);
	
	my $val = unpack('I', unpack('P4', pack('I', $addr)));
	
	ok(($val == 0xdeadbeef) ? 3 : 0);
	
	my $point = NSMakePoint(5.0, 5.0);
	CBPoke($addr, $point);
	ok(4);
	
	my ($x, $y) = unpack('ff', unpack('P16', pack('I', $addr)));
	ok(($x == 5 && $y == 5) ? 5 : 0);
}