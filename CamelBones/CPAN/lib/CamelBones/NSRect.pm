use strict;
use warnings;

package CamelBones::NSRect;

our @ISA = qw(Exporter);

#test for 64/32 bit intel perl
our $unpack_template  = (pack 'P', -1 == 8) ? 'dddddddd': 'ffffffff'; 
our $pack_template  = (pack 'P', -1 == 8) ? 'dddd': 'ffff'; 

sub getX {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	return $x;
}

sub getY {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	return $y;
}

sub getWidth {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	return $width;
}

sub getHeight {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	return $height;
}

sub setX {
	my ($self, $newX) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $newX, $y, $width, $height);
}

sub setY {
	my ($self, $newY) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $x, $newY, $width, $height);
}

sub setWidth {
	my ($self, $newWidth) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $x, $y, $newWidth, $height);
}

sub setHeight {
	my ($self, $newHeight) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $x, $y, $width, $newHeight);
}

sub setAll {
	my ($self, $newX, $newY, $newWidth, $newHeight) = @_;
	$$self = pack($pack_template, $newX, $newY, $newWidth, $newHeight);
}

sub getHashref {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	
	return {
		'x' => $x,
		'y' => $y,
		'width' => $width,
		'height' => $height,
	};
}

sub getArrayref {
	my ($self) = @_;
	my ($x, $y, $width, $height) = unpack($pack_template, $$self);
	
	return [$x, $y, $width, $height];
}

1;
