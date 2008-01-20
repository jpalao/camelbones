use strict;
use warnings;

BEGIN {
    if ($ENV{'PERL_CORE'}){
        chdir 't';
        unshift @INC, '../lib';
    }

    require($ENV{PERL_CORE} ? "./test.pl" : "./t/test.pl");

    use Config;
    if (! $Config{'useithreads'}) {
        skip_all(q/Perl not compiled with 'useithreads'/);
    }

    plan(11);
}

use ExtUtils::testlib;

use_ok('threads');

### Start of Testing ###

my $i = 10;
my $y = 20000;

my %localtime;
for (1..$i) {
    $localtime{$_} = localtime($_);
};

my @threads;
for (1..$i) {
    $threads[$_] = threads->create(sub {
                        my $arg = shift;
                        my $localtime = $localtime{$arg};
                        my $error = 0;
                        for (1..$y) {
                            my $lt = localtime($arg);
                            if ($localtime ne $lt) {
                                $error++;
                            }
                        }
                        return $error;
                    }, $_);
}

for (1..$i) {
    is($threads[$_]->join(), 0, 'localtime() thread-safe');
}

# EOF
