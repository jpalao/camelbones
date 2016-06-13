use strict;
use warnings;

package CamelBones::NSSize;

our @ISA = qw(Exporter);

#test for 64/32 bit intel perl
our $pack_template  = (length (pack 'P', -1) == 8) ? 'dd': 'ff'; 

sub getWidth {
	my ($self) = @_;
	my ($width, $height) = unpack($pack_template, $$self);
	return $width;
}

sub getHeight {
	my ($self) = @_;
	my ($width, $height) = unpack($pack_template, $$self);
	return $height;
}

sub setWidth {
	my ($self, $newWidth) = @_;
	my ($width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $newWidth, $height);
}

sub setHeight {
	my ($self, $newHeight) = @_;
	my ($width, $height) = unpack($pack_template, $$self);
	$$self = pack($pack_template, $width, $newHeight);
}

sub setAll {
	my ($self, $newWidth, $newHeight) = @_;
	$$self = pack($pack_template, $newWidth, $newHeight);
}

sub getHashref {
	my ($self) = @_;
	my ($width, $height) = unpack($pack_template, $$self);

	return {
		'width' => $width,
		'height' => $height,
	};
}

sub getArrayref {
	my ($self) = @_;
	my ($width, $height) = unpack($pack_template, $$self);

	return [$width, $height];
}

1;
