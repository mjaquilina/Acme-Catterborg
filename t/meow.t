#!/usr/bin/perl

use strict;
use warnings;

use Acme::Catterborg;

$ENV{CEILING_CAT_POWERS} = 1;

print Acme::Catterborg::meow("the weather on the ceiling is frightful") . "\n";
print Acme::Catterborg::meow("the sun is bright") . "\n";

