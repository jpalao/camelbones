use strict;
use warnings;

package CamelBones::NSRange;

our @ISA = qw(Exporter);

#test for 64/32 bit intel perl
our $pack_template  = (length (pack 'P', -1) == 8) ? 'QQ': 'II'; 

sub getLocation {
	my ($self) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	return $location;
}

sub getLength {
	my ($self) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	return $length;
}

sub setLocation {
	my ($self, $newLocation) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	$$self = pack( $pack_template, $newLocation, $length);
}

sub setLength {
	my ($self, $newLength) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	$$self = pack( $pack_template, $location, $newLength);
}

sub setAll {
	my ($self, $newLocation, $newLength) = @_;
	$$self = pack( $pack_template, $newLocation, $newLength);
}

sub getHashref {
	my ($self) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	
	return {
		'location' => $location,
		'length' => $length,
	};
}

sub getArrayref {
	my ($self) = @_;
	my ($location, $length) = unpack( $pack_template, $$self);
	
	return [$location, $length];
}

1;
