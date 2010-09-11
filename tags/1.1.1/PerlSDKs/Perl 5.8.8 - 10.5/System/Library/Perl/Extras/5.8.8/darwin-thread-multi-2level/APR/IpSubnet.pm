# 
# /*
#  * *********** WARNING **************
#  * This file generated by ModPerl::WrapXS/0.01
#  * Any changes made here will be lost
#  * ***********************************
#  * 01: lib/ModPerl/Code.pm:708
#  * 02: lib/ModPerl/WrapXS.pm:624
#  * 03: lib/ModPerl/WrapXS.pm:1173
#  * 04: Makefile.PL:423
#  * 05: Makefile.PL:325
#  * 06: Makefile.PL:56
#  */
# 


package APR::IpSubnet;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::IpSubnet - Perl API for accessing APRs ip_subnet structures




=head1 Synopsis

  use APR::IpSubnet ();
  
  my $ipsub = APR::IpSubnet->new($pool, "127.0.0.1");
  $ok = $ipsub->test($sock_addr);





=head1 Description

C<APR::IpSubnet> object represents a range of IP addresses
(IPv4/IPv6). A socket connection can be matched against this range to
test whether the IP it's coming from is inside or outside of this
range.




=head1 API

C<APR::IpSubnet> provides the following functions and/or methods:



=head2 C<new>

Create an IP subnet represenation object

  $ipsubnet = APR::IpSubnet->new($pool, $ip);
  $ipsubnet = APR::IpSubnet->new($pool, $ip, $mask_or_numbits);

=over 4

=item obj: C<APR::IpSubnet> (class name)

=item arg1: C<$pool>
( C<L<APR::Pool object|docs::2.0::api::APR::Pool>> )

=item arg2: C<$ip> ( string )

IP address in one of the two formats: IPv4 (e.g. I<"127.0.0.1">) or
IPv6 (e.g. I<"::1">). IPv6 addresses are accepted only if APR has the
IPv6 support enabled.

=item opt arg3: C<$mask_or_numbits> ( string )

An optional IP mask (e.g. I<"255.0.0.0">) or number of bits
(e.g. I<"15">).

If none provided, the default is not to mask off.

=item ret: C<$ret>
( C<L<APR::IpSubnet object|docs::2.0::api::APR::IpSubnet>> )

The IP-subnet object

=item excpt: C<L<APR::Error|docs::2.0::api::APR::Error>>

=item since: 2.0.00

=back


=head2 C<test>

Test the IP address in the socket address object against a pre-built
ip-subnet representation.

  $ret = $ipsub->test($sockaddr);

=over 4

=item obj: C<$ipsub>
( C<L<APR::IpSubnet object|docs::2.0::api::APR::IpSubnet>> )

The ip-subnet representation

=item arg1: C<$sockaddr>
( C<L<APR::SockAddr object|docs::2.0::api::APR::SockAddr>> )

The socket address to test

=item ret: C<$ret> ( boolean )

true if the socket address is within the subnet, false otherwise

=item since: 2.0.00

=back

This method is used for testing whether or not an address is within a
subnet. It's used by module C<mod_access> to check whether the client
IP fits into the IP range, supplied by C<Allow>/C<Deny> directives.

Example:

Allow accesses only from the localhost (IPv4):

  use APR::IpSubnet ();
  use Apache2::Connection ();
  use Apache2::RequestRec ();
  my $ipsub = APR::IpSubnet->new($r->pool, "127.0.0.1");
  ok $ipsub->test($r->connection->remote_addr);







=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

