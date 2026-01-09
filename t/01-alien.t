use strict;
use warnings;
use Test::More;
use Test::Alien;

BEGIN { plan skip_all => 'Test::Alien required' unless eval { require Test::Alien; 1 } }

plan tests => 3;

use Alien::nghttp2;

alien_ok 'Alien::nghttp2';

my $xs = do { local $/; <DATA> };
xs_ok $xs, with_subtest {
    my ($module) = @_;
    my $version = $module->version();
    ok $version, "nghttp2 version: $version";
    diag "nghttp2 library version: $version";
};

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <nghttp2/nghttp2.h>

MODULE = TA_nghttp2 PACKAGE = TA_nghttp2

const char *
version()
    CODE:
        nghttp2_info *info = nghttp2_version(0);
        RETVAL = info->version_str;
    OUTPUT:
        RETVAL
