# perl -I.

use strict;
use warnings;

use Anonymise::Utilities;

my $test = Anonymise::Utilities->new();

my $key = $test->create_keys();
print "* Test create_keys \n$key\n";

print "#############################################################\n";
my $str = "BLABLABLA";
my $scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
$str = "B";
$scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhseciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
print "Testing with LENGTH " . length($str) . "\n";
$scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
$str = '/ajcprivMethodscala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspectscala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspectgetAssistImageDescriptor';
$scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
$str = '/ajc$privMethod$scala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspect$scala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspect$getAssistImageDescriptor';
$scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
print "Testing with LENGTH " . length($str) . "\n";
$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $test->scramble_string($str);
print "* Test scramble_string " . length($str) . " => " . length($scrambled) 
    . " chars\n$scrambled \n";

print "#############################################################\n";
my $enc = $test->encode_string("BLABLABLA");
print "* Test encode_string => " . length($enc) . " chars\n$enc \n";
print "#############################################################\n";
my $enc64 = $test->encode_string_base64("BLABLABLA");
print "* Test encode_string_base64 => " . length($enc64) . " chars\n$enc64\n";
print "#############################################################\n";
my $dec = $test->decode_string($enc);
print "* Test decode_string => " . length($dec) . " chars\n" . $dec . "\n";


