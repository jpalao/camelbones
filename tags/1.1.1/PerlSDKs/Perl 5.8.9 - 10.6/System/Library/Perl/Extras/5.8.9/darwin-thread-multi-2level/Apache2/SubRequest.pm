# 
# /*
#  * *********** WARNING **************
#  * This file generated by ModPerl::WrapXS/0.01
#  * Any changes made here will be lost
#  * ***********************************
#  * 01: lib/ModPerl/Code.pm:709
#  * 02: lib/ModPerl/WrapXS.pm:626
#  * 03: lib/ModPerl/WrapXS.pm:1175
#  * 04: Makefile.PL:423
#  * 05: Makefile.PL:325
#  * 06: Makefile.PL:56
#  */
# 


package Apache2::SubRequest;

use strict;
use warnings FATAL => 'all';

@Apache2::SubRequest::ISA = 'Apache2::RequestRec';


use Apache2::XSLoader ();
our $VERSION = '2.000004';
Apache2::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

Apache2::SubRequest - Perl API for Apache subrequests




=head1 Synopsis

  use Apache2::SubRequest ();
  
  # run internal redirects at once
  $r->internal_redirect($new_uri);
  $r->internal_redirect_handler($new_uri);
  
  # create internal redirect objects
  $subr = $r->lookup_uri("/foo");
  $subr = $r->lookup_method_uri("GET", "/tmp/bar")
  $subr = $r->lookup_file("/tmp/bar");
  # optionally manipulate the output through main request filters
  $subr = $r->lookup_uri("/foo", $r->output_filters);
  # now run them
  my $rc = $subr->run;




=head1 Description

C<Apache2::SubRequest> contains API for creating and running of Apache
sub-requests.

C<Apache2::SubRequest> is a sub-class of C<L<Apache2::RequestRec
object|docs::2.0::api::Apache2::RequestRec>>.







=head1 API

C<Apache2::SubRequest> provides the following functions and/or methods:





=head2 C<DESTROY>

Free the memory associated with a sub request:

  undef $subr; # but normally don't do that

=over 4

=item obj: C<$subr> ( C<L<Apache2::SubRequest
object|docs::2.0::api::Apache2::SubRequest/Description>> )

The sub request to finish

=item ret: no return value

=item since: 2.0.00

=back

C<DESTROY> is called automatically when C<$subr> goes out of scope.

If you want to free the memory earlier than that (for example if you
run several subrequests), you can C<undef> the object as:

  undef $subr;

but never call C<DESTROY> explicitly, since it'll result in
C<ap_destroy_sub_req> being called more than once, resulting in
multiple brain injuries and certain hair loss.












=head2 C<internal_redirect>

Redirect the current request to some other uri internally

  $r->internal_redirect($new_uri);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$new_uri> ( string )

The URI to replace the current request with

=item ret: no return value

=item since: 2.0.00

=back

In case that you want some other request to be served as the top-level
request instead of what the client requested directly, call this
method from a handler, and then immediately return C<Apache2::Const::OK>. The
client will be unaware the a different request was served to her
behind the scenes.








=head2 C<internal_redirect_handler>

Identical to C<L<internal_redirect|/C_internal_redirect_>>, plus
automatically sets
C<L<$r-E<gt>content_type|docs::2.0::api::Apache2::RequestRec/C_content_type_>>
is of the sub-request to be the same as of the main request, if
C<L<$r-E<gt>handler|docs::2.0::api::Apache2::RequestRec/C_handler_>> is
true.

  $r->internal_redirect_handler($new_uri);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$new_uri> ( string )

The URI to replace the current request with.

=item ret: no return value

=item since: 2.0.00

=back

This function is designed for things like actions or CGI scripts, when
using C<AddHandler>, and you want to preserve the content type across
an internal redirect.










=head2 C<lookup_file>

Create a subrequest for the given file.  This sub request can be
inspected to find information about the requested file

  $ret = $r->lookup_file($new_file);
  $ret = $r->lookup_file($new_file, $next_filter);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$new_file> ( string )

The file to lookup

=item opt arg2: C<$next_filter>
( C<L<Apache2::Filter|docs::2.0::api::Apache2::Filter>> )

See C<L<$r-E<gt>lookup_uri|/C_lookup_uri_>> for details.

=item ret: C<$ret> ( C<L<Apache2::SubRequest
object|docs::2.0::api::Apache2::SubRequest/Description>> )

The sub request record.

=item since: 2.0.00

=back

See C<L<$r-E<gt>lookup_uri|/C_lookup_uri_>> for further discussion.




=head2 C<lookup_method_uri>

Create a sub request for the given URI using a specific method.  This
sub request can be inspected to find information about the requested
URI

  $ret = $r->lookup_method_uri($method, $new_uri);
  $ret = $r->lookup_method_uri($method, $new_uri, $next_filter);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$method> ( string )

The method to use in the new sub request (e.g. C<"GET">)

=item arg2: C<$new_uri> ( string )

The URI to lookup

=item opt arg3: C<$next_filter>
( C<L<Apache2::Filter object|docs::2.0::api::Apache2::Filter>> )

See C<L<$r-E<gt>lookup_uri|/C_lookup_uri_>> for details.

=item ret: C<$ret> ( C<L<Apache2::SubRequest
object|docs::2.0::api::Apache2::SubRequest/Description>> )

The sub request record.

=item since: 2.0.00

=back

See C<L<$r-E<gt>lookup_uri|/C_lookup_uri_>> for further discussion.





=head2 C<lookup_uri>

Create a sub request from the given URI.  This sub request can be
inspected to find information about the requested URI.

  $ret = $r->lookup_uri($new_uri);
  $ret = $r->lookup_uri($new_uri, $next_filter);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$new_uri> ( string )

The URI to lookup

=item opt arg2: C<$next_filter>
( C<L<Apache2::Filter object|docs::2.0::api::Apache2::Filter>> )

The first filter the subrequest should pass the data through.  If not
specified it defaults to the first connection output filter for the
main request
C<L<$r-E<gt>proto_output_filters|docs::2.0::api::Apache2::RequestRec/C_proto_output_filters_>>. So
if the subrequest sends any output it will be filtered only once. If
for example you desire to apply the main request's output filters to
the sub-request output as well pass
C<L<$r-E<gt>output_filters|docs::2.0::api::Apache2::RequestRec/C_output_filters_>>
as an argument.

=item ret: C<$ret> ( C<L<Apache2::SubRequest
object|docs::2.0::api::Apache2::SubRequest/Description>> )

The sub request record

=item since: 2.0.00

=back

Here is an example of a simple subrequest which serves uri
I</new_uri>:

  sub handler {
      my $r = shift;
  
      my $subr = $r->lookup_uri("/new_uri");
      $sub->run;
  
      return Apache2::Const::OK;
  }

If let's say you have three request output filters registered to run
for the main request:

  PerlOutputFilterHandler MyApache2::SubReqExample::filterA
  PerlOutputFilterHandler MyApache2::SubReqExample::filterB
  PerlOutputFilterHandler MyApache2::SubReqExample::filterC

and you wish to run them all, the code needs to become:

      my $subr = $r->lookup_uri("/new_uri", $r->output_filters);

and if you wish to run them all, but the first one (C<filterA>), the
code needs to be adjusted to be:

      my $subr = $r->lookup_uri("/new_uri", $r->output_filters->next);





=head2 C<run>

Run a sub-request

  $rc = $subr->run();

=over 4

=item obj: C<$subr>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The sub-request (e.g. returned by C<L<lookup_uri|/C_lookup_uri_>>)

=item ret: C<$rc> ( integer )

The return code of the handler (C<Apache2::Const::OK>, C<Apache2::Const::DECLINED>,
etc.)

=item since: 2.0.00

=back






=head1 Unsupported API

C<Apache2::SubRequest> also provides auto-generated Perl interface for
a few other methods which aren't tested at the moment and therefore
their API is a subject to change. These methods will be finalized
later as a need arises. If you want to rely on any of the following
methods please contact the L<the mod_perl development mailing
list|maillist::dev> so we can help each other take the steps necessary
to shift the method to an officially supported API.






=head2 C<internal_fast_redirect>

META: Autogenerated - needs to be reviewed/completed

Redirect the current request to a sub_req, merging the pools

  $r->internal_fast_redirect($sub_req);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$sub_req> ( string )

A subrequest created from this request

=item ret: no return value

=item since: 2.0.00

=back


META: httpd-2.0/modules/http/http_request.c declares this function as:

  /* XXX: Is this function is so bogus and fragile that we deep-6 it? */

do we really want to expose it to mod_perl users?






=head2 C<lookup_dirent>

META: Autogenerated - needs to be reviewed/completed

Create a sub request for the given apr_dir_read result.  This sub request
can be inspected to find information about the requested file

  $lr = $r->lookup_dirent($finfo);
  $lr = $r->lookup_dirent($finfo, $subtype);
  $lr = $r->lookup_dirent($finfo, $subtype, $next_filter);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$finfo>
( C<L<APR::Finfo object|docs::2.0::api::APR::Finfo>> )

The apr_dir_read result to lookup

=item arg2: C<$subtype> ( integer )

What type of subrequest to perform, one of;

  Apache2::SUBREQ_NO_ARGS     ignore r->args and r->path_info
  Apache2::SUBREQ_MERGE_ARGS  merge  r->args and r->path_info

=item arg3: C<$next_filter> ( integer )

The first filter the sub_request should use.  If this is
NULL, it defaults to the first filter for the main request

=item ret: C<$lr>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The new request record

=item since: 2.0.00

=back

META: where do we take the apr_dir_read result from?





=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

