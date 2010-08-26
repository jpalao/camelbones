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


package ModPerl::Global;

use strict;
use warnings FATAL => 'all';



use Apache2::XSLoader ();
our $VERSION = '2.000002';
Apache2::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

ModPerl::Global -- Perl API for manipulating special Perl lists




=head1 Synopsis

  use ModPerl::Global ();
  my $package = 'MyApache2::Package';
  
  # make the END blocks of this package special
  ModPerl::Global::special_list_register(END => $package);
  
  # Execute all encoutered END blocks from this package now
  ModPerl::Global::special_list_call(    END => $package);
  
  # delete the list of END blocks
  ModPerl::Global::special_list_clear(   END => $package);




=head1 Description

C<ModPerl::Global> provides an API to manipulate special perl
lists. At the moment only the C<END> blocks list is supported.

This API allows you to change the normal Perl behavior, and execute
special lists when you need to.

For example
C<L<ModPerl::RegistryCooker|docs::2.0::api::ModPerl::RegistryCooker>>
uses it to run C<END> blocks in the scripts at the end of each
request.

Before loading a module containing package C<$package>, you need to
register it, so the special blocks will be intercepted by mod_perl and
not given to
Perl. C<L<special_list_register|/C_special_list_register_>> does
that. Later on when you want to execute the special blocks,
C<L<special_list_call|/C_special_list_call_>> should be called. Unless
you want to call the list more than once, clear the list with
C<L<special_list_clear|/C_special_list_clear_>>.

=head1 API

C<ModPerl::Global> provides the following methods:










=head2 C<special_list_call>

Call the special list

  $ok = special_list_call($key => $package);

=over 4

=item arg1: C<$key> ( string )

The name of the special list. At the moment only C<'END'> is
supported.

=item arg2: C<$package> ( string )

what package to special list is for

=item ret: C<$ok> ( boolean )

true value if C<$key> is known, false otherwise.

=item since: 2.0.00

=back





=head2 C<special_list_clear>

Clear the special list

  $ok = special_list_clear($key => $package);

=over 4

=item arg1: C<$key> ( string )

The name of the special list. At the moment only C<'END'> is
supported.

=item arg2: C<$package> ( string )

what package to special list is for

=item ret: C<$ok> ( boolean )

true value if C<$key> is known, false otherwise.

=item since: 2.0.00

=back




=head2 C<special_list_register>

Register the special list

  $ok = special_list_call($key => $package);

=over 4

=item arg1: C<$key> ( string )

The name of the special list. At the moment only C<'END'> is
supported.

=item arg2: C<$package> ( string )

what package to special list is for

=item ret: C<$ok> ( boolean )

true value if C<$key> is known, false otherwise.

=item since: 2.0.00

=back

Notice that you need to register the package before it is loaded. If
you register it after, Perl has already compiled the C<END> blocks and
there are no longer under your control.



=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

