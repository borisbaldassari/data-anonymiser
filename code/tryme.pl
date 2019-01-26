
use strict;
use warnings;
    
use Anonymise::Utilities;

use Data::Dumper;

my $rsa_pub = "public_key.der";
my $rsa_priv = "private_key.der";
my $str = 'boris.baldassari@gmail.com';

print "# Creating new Utils.\n";
my $utils = Anonymise::Utilities->new();

my $key_pub64 = $utils->create_keys();
my $key_pub = $utils->export_public_key_der();
my $key_priv = $utils->export_private_key_der();

#print Dumper($key_pub);

print "Writing public key to file.\n";
open( my $fh, ">$rsa_pub" ) or die "Can't open file $rsa_pub.";
print $fh $key_pub;
close($fh);

print "Writing private key to file.\n";
open( $fh, ">$rsa_priv" ) or die "Can't open file $rsa_priv.";
print $fh $key_priv;
close($fh);

my $enc = $utils->encode_string_base64($str);
print "Encoded base 64: \n";
print Dumper($enc);

my $enc_bin = $utils->encode_string($str);
print "Encoded.\n";

my $enc64 = $utils->scramble_string($str);
print "Scrambled base 64: \n";
print Dumper($enc64);

print "Saving all mappings.\n";
$utils->write_maps('mytest.data');


print "\n";
print "# Creating new Utils (2).\n\n";
my $utils2 = Anonymise::Utilities->new();
my $key_pub64_2 = $utils2->create_keys();

print "Importing public key.\n";
#$utils2->set_key($key_priv);
#$utils2->import_public_key_der($key_pub);

my $key2_pub = $utils2->export_public_key_der();
#print Dumper($key2_pub);

my $key2_priv = $utils2->export_private_key_der();

$enc = $utils2->encode_string_base64($str);
print "Encoded base 64: \n";
print Dumper($enc);

$enc64 = $utils2->scramble_string($str);
print "Scrambled base 64: \n";
print Dumper($enc64);

$enc64 = $utils2->scramble_string($str);
print "Scrambled base 64: \n";
print Dumper($enc64);

print "Saving scrambled mapping.\n";
$utils2->_save_scrambled();

print "Saving all mappings.\n";
$utils2->write_maps('mytest2.data');

undef($utils);
undef($utils2);

print "\n";
print "# Creating new Utils (3).\n\n";
my $utils3 = Anonymise::Utilities->new(); 
my $key_pub64_3 = $utils3->create_keys();

print "DBG " . Dumper($utils3);
print "DBG " . Dumper($utils3->_get_known_scramble());

$enc64 = $utils3->scramble_string($str);
print "Scrambled base 64 before reading mapping: \n";
print Dumper($enc64);

print "Restoring all mappings.\n";
$utils3->read_maps('mytest.data');
$utils3->import_public_key_der($key_pub);
$utils3->import_private_key_der($key_priv);
  
print "Trying to decode string.\n";
my $dec = $utils3->decode_string($enc_bin);
print "Restored string using priv/pub keys: \n";
print Dumper($dec);

$enc64 = $utils3->scramble_string($str);
print "Scrambled base 64: \n";
print Dumper($enc64);

print "END\n";

