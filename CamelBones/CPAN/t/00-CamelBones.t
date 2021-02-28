use Test;
BEGIN { plan tests => 2 };
use CamelBones qw(:None);
ok(1); 
use CamelBones qw(:All);
ok(2); # If we made it this far, we're ok.
