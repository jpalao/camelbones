use strict;
use warnings;

package CamelBones::CGPoint;

our @ISA = qw(Exporter);

#test for 64/32 bit intel perl
our $pack_template  = (pack 'P', -1 == 8) ? 'dd': 'ff'; 

sub getX {
	my ($self) = @_;
	my ($x, $y) = unpack($pack_template, $$self);
	return $x;
}

sub getY {
	my ($self) = @_;
	my ($x, $y) = unpack($pack_template, $$self);
	return $y;
}

sub setX {
	my ($self, $newx) = @_;
	my ($x, $y) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $newx, $y);
}

sub setY {
	my ($self, $newy) = @_;
	my ($x, $y) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $x, $newy);
}

sub setAll {
	my ($self, $newx, $newy) = @_;
	$$self = pack($pack_template, $newx, $newy);
	$$self = pack($pack_template, $newx, $newy);
}

sub getHashref {
	my ($self) = @_;
    my ($x, $y) = unpack($pack_template, $$self);
	return {
		'x' => $x,
		'y' => $y,
	};
}

sub getArrayref {
	my ($self) = @_;
    my ($x, $y) = unpack($pack_template, $$self);
	return [$x, $y];
}

1;
