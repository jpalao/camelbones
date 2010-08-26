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


package Apache2::Module;

use strict;
use warnings FATAL => 'all';



use Apache2::XSLoader ();
our $VERSION = '2.000002';
Apache2::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

Apache2::Module - Perl API for creating and working with Apache modules




=head1 Synopsis

  use Apache2::Module ();
  
  #Define a configuration directive
  my @directives = (
      {
          name => 'MyDirective',
      }
  );
  
  Apache2::Module::add(__PACKAGE__, \@directives);
  
  # iterate over the whole module list
  for (my $modp = Apache2::Module::top_module(); $modp; $modp = $modp->next) {
      my $name                  = $modp->name;
      my $index                 = $modp->module_index;
      my $ap_api_major_version  = $modp->ap_api_major_version;
      my $ap_api_minor_version  = $modp->ap_api_minor_version;
      my $commands              = $modp->cmds;
  }
  
  # find a specific module
  my $module = Apache2::Module::find_linked_module('mod_ssl.c');
  
  # remove a specific module
  $module->remove_loaded_module();
  
  # access module configuration from a directive
  sub MyDirective {
      my ($self, $parms, $args) = @_;
      my  $srv_cfg = Apache2::Module::get_config($self, $parms->server);
      [...]
  }
  
  # test if an Apache module is loaded
  if (Apache2::Module::loaded('mod_ssl.c')) {
      [...]
  }
  
  # test if a Perl module is loaded
  if (Apache2::Module::loaded('Apache2::Status')) {
      [...]
  }







=head1 Description

C<Apache2::Module> provides the Perl API for creating and working with
Apache modules

See L<Apache Server Configuration Customization in
Perl|docs::2.0::user::config::custom>.





=head1 API

C<Apache2::Module> provides the following functions and/or methods:





=head2 C<add>

Add a module's custom configuration directive to Apache.

  Apache2::Module::add($package, $cmds);

=over 4

=item arg1: C<$package> ( string )

the package of the module to add

=item arg2: C<$cmds> ( ARRAY of HASH refs )

the list of configuration directives to add

=item ret: no return value

=item since: 2.0.00

=back

See also L<Apache Server Configuration Customization in
Perl|docs::2.0::user::config::custom>.







=head2 C<ap_api_major_version>

Get the httpd API version this module was build against, B<not> the
module's version.

  $major_version = $module->ap_api_major_version();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$major_version> ( integer )

=item since: 2.0.00

=back

This methid is used to check that module is compatible with this
version of the server before loading it.






=head2 C<ap_api_minor_version>

Get the module API minor version.

  $minor_version = $module->ap_api_minor_version();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$minor_version> ( integer )

=item since: 2.0.00

=back

C<ap_api_minor_version()> provides API feature milestones.

It's not checked during module init.





=head2 C<cmds>

Get the C<L<Apache2::Command|docs::2.0::api::Apache2::Command>> object,
describing all of the directives this module defines.

  $command = $module->cmds();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$command>
( C<L<Apache2::Command object|docs::2.0::api::Apache2::Command>> )

=item since: 2.0.00

=back







=head2 C<get_config>

Retrieve a module's configuration. Used by configuration directives.

  $cfg = Apache2::Module::get_config($class, $server, $dir_config);
  $cfg = Apache2::Module::get_config($class, $server);
  $cfg =          $self->get_config($server, $dir_config);
  $cfg =          $self->get_config($server);

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item arg1: C<$class> ( string )

The Perl package this configuration is for

=item arg2: C<$server>
( C<L<Apache2::ServerRec object|docs::2.0::api::Apache2::ServerRec>> )

The current server, typically
C<L<$r-E<gt>server|docs::2.0::api::Apache2::ServerUtil>> or
C<L<$parms-E<gt>server|docs::2.0::api::Apache2::CmdParms>>.

=item opt arg3: C<$dir_config>
( C<L<Apache2::ConfVector object|docs::2.0::api::Apache2::ConfVector>> )

By default, the configuration returned is the server level one. To
retrieve the per directory configuration, use
C<L<$r-E<gt>per_dir_config|docs::2.0::api::Apache2::RequestRec>> as a
last argument.

=item ret: C<$cfg> (HASH reference)

A reference to the hash holding the module configuration data.

=item since: 2.0.00

=back

See also L<Apache Server Configuration Customization in
Perl|docs::2.0::user::config::custom>.






=head2 C<find_linked_module>

Find a module based on the name of the module

  $module = Apache2::Module::find_linked_module($name);

=over 4

=item arg1: C<$name> ( string )

The name of the module ending in C<.c>

=item ret: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

The module object if found, C<undef> otherwise.

=item since: 2.0.00

=back

For example:

  my $module = Apache2::Module::find_linked_module('mod_ssl.c');






=head2 C<loaded>

Determine if a certain module is loaded

  $loaded = Apache2::Module::loaded($module);

=over 4

=item name: C<$module> ( string )

The name of the module to search for.

If C<$module> ends with C<.c>, search all the modules, statically
compiled and dynamically loaded.

If C<$module> ends with C<.so>, search only the dynamically loaded
modules.

If C<$module> doesn't contain a C<.>, search the loaded Perl modules
(checks C<%INC>).

=item ret: C<$loaded> ( boolean )

Returns true if the module is loaded, false otherwise.

=item since: 2.0.00

=back

For example, to test if this server supports ssl:

  if (Apache2::Module::loaded('mod_ssl.c')) {
      [...]
  }

To test is this server dynamically loaded mod_perl:

  if (Apache2::Module::loaded('mod_perl.so')) {
      [...]
  }

To test if C<L<Apache2::Status|docs::2.0::api::Apache2::Status>> is
loaded:

  if (Apache2::Module::loaded('Apache2::Status')) {
      [...]
  }







=head2 C<module_index>

Get the index to this modules structures in config vectors.

  $index = $module->module_index();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$index> ( integer )

=item since: 2.0.00

=back





=head2 C<name>

Get the name of the module's I<.c> file

  $name = $module->name();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$name> ( string )

=item since: 2.0.00

=back

For example a mod_perl module, will return: I<mod_perl.c>.








=head2 C<next>

Get the next module in the list, C<undef> if this is the last module
in the list.

  $next_module = $module->next();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: C<$next_module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item since: 2.0.00

=back








=head2 C<remove_loaded_module>

Remove a module from the list of loaded modules permanently.

  $module->remove_loaded_module();

=over 4

=item obj: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item ret: no return value

=item since: 2.0.00

=back






=head2 C<top_module>

Returns the first module in the module list. Usefull to start a
module iteration.

  $module = Apache2::Module::top_module();

=over 4

=item ret: C<$module>
( C<L<Apache2::Module object|docs::2.0::api::Apache2::Module>> )

=item since: 2.0.00

=back





=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

