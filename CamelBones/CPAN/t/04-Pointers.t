use Test::More;
BEGIN { plan tests => 2 };

use CamelBones qw(:All);
ok(1);

my $error;
my $data = NSData->dataWithContentsOfFile_options_error("/no/such/file", 0, $error);
ok($error->domain() eq 'NSCocoaErrorDomain' ? 2 : 0);
