use Test;

BEGIN { plan tests => 3; }

use CamelBones qw(:All);
ok(1);

use InterfaceBuilder;
ok(2);

eval "use NoSuchModuleExists";
ok(3);