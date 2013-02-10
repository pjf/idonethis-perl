#!/usr/bin/perl -w
use 5.010;
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Config::Tiny;
use WebService::Idonethis;

my $config = Config::Tiny->read("$ENV{HOME}/.idonethisrc");

if (not $config->{auth}{user}) {
    plan skip_all => "No login data in ~/.idonethisrc";
}

throws_ok 
    { WebService::Idonethis->new( user => "notauser", pass => "notapass") }
    qr{Login.*failed},
    "Login fails with bogus credentials"
;

my $idt = WebService::Idonethis->new(
    user => $config->{auth}{user},
    pass => $config->{auth}{pass},
);

ok(1, "Login successful");

done_testing;
