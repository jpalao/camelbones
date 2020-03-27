use strict;
use warnings;

package CamelBones::CoreGraphics;

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '1.2.0';
our @EXPORT = qw(
			  );
our @EXPORT_OK = qw(
		CGPointMake CGAffineTransformMake CGPathGetBoundingBox
				   );
our %EXPORT_TAGS = (
    'All'		=> [@EXPORT_OK],
);

require XSLoader;
XSLoader::load('CamelBones::CoreGraphics');

1;