# perl -I.

use strict;
use warnings;

use Anonymise::Utilities;

my $test = Anonymise::Utilities->new();

my $key = $test->create_keys();
print "* Test create_keys \n$key\n";

my $enc = $test->encode_string("BLABLABLA");
print "* Test encode_string => " . length($enc) . " chars\n$enc \n";
my $enc64 = $test->encode_string_base64("BLABLABLA");
print "* Test encode_string_base64 => " . length($enc64) . " chars\n$enc64\n";
my $dec = $test->decode_string($enc);
print "* Test decode_string => " . length($dec) . " chars\n" . $dec . "\n";


