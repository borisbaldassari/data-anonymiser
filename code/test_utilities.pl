
use strict;
use warnings;

use Anonymise::Utilities;

my $test = Anonymise::Utilities->new();
print "TEST: " . $test->create_keys() . "\n";
my $enc = $test->encode_string("BLABLABLA");
print "TEST2 [$enc].\n";
my $enc64 = $test->encode_string_base64("BLABLABLA");
print "TEST2 b64 [$enc64].\n";
my $dec = $test->decode_string($enc);
print "TEST3: " . $dec . "\n";


