######################################################################
# Copyright (c) 2017-2018 Castalia Solutions and others
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
######################################################################


use strict;
use warnings;

use Data::Dumper;
use Test::More;

# We do not really need it, but the Perl module we test will.
use_ok('Crypt::PK::RSA');

use_ok('Anonymise::Utilities');

my $utils = Anonymise::Utilities->new();
isa_ok($utils, "Anonymise::Utilities");

note("Create keys.");
my $key = $utils->create_keys();
ok($key =~ m!^MII!, "Public key starts with MII...");
ok(length($key) == 746, "Public key has length 746.");

my $key_export = $utils->export_private_key_der();

note("Apply anonymisation to various entries.");
my $str = "B";
my $scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for input 1 char is 16 chars long.");

$str = "BLABLABLA";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for input 9 char is 16 chars long.");

my $scrambled2 = $utils->scramble_string($str);
ok(length($scrambled2) == 16, "Scrambled output for input 9 char is 16 chars long.");
ok($scrambled eq $scrambled2, "Scrambled outputs are equal.");

note("Re-import exported key.");
$utils->create_keys();
$utils->import_private_key_der($key_export);

my $scrambled_newkey = $utils->scramble_string($str);
ok($scrambled eq $scrambled_newkey, "Scrambled outputs after key import are equal.");

note("Create new object, re-import exported key.");
my $utils2 = Anonymise::Utilities->new();
$utils2->import_private_key_der($key_export);
my $scrambled_newkey2 = $utils2->scramble_string($str);
ok($scrambled eq $scrambled_newkey2, "Scrambled outputs after new object & import are equal.");


$str = "Blmeciruvqfl6546878454hsqjshdayuyuiyuyuyi878797987uzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for input " . length($str) . " char is 16 chars long.");

$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhseciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for in " . length($str) . " char is 16 chars long.");

$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhseciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzeclegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for in " . length($str) . " char is 16 chars long.");

$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhseciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzeclegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzeclegffffffffffzazerazecezrcazvrcajmlkjgmiueirlthkjhkjhjjjjjjjjjjjlkiuyoiuzfdGxbrouhncsfdhdhsqjshdayuzegeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for in " . length($str) . " char is 16 chars long.");

$str = '/ajcprivMethodscala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspectscala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspectgetAssistImageDescriptor';
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for test case is 16 chars long.");

$str = '/ajc$privMethod$scala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspect$scala_tools_eclipse_contribution_weaving_jdt_imagedescriptor_ImageDescriptorSelectorAspect$getAssistImageDescriptor';
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for test case 2 is 16 chars long.");

$str = "Blmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbhoBlmeciruvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouhncsfdhdhsqjshdayuzegfbuayzeirzecluiyfdshbcbqsfdhjbho";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for test case 3 is 16 chars long.");

$str = "BLABLABLA";
my $enc = $utils->encode_string($str);
ok(length($enc) == 512, "Encoded string for input 9 chars is 512 chars long.");

my $enc64 = $utils->encode_string_base64($str);
ok(length($enc64) == 692, "Encoded string for input 9 chars is 692 chars long.");
my $dec = $utils->decode_string($enc);
ok($dec eq $str, "Decoded string is equal to original string.");

$str = 'BLABdfalkyuuvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrouvqflbuscrnazemicqfsvbljsclnzerucrbsqfhjgqbsdfxeidn<scbfshcgqlkunrLCUEBCHDQSFSDGHCKJEGxbrokjh4k3h5lkjhI*&(*$khjkjkljfhfksjh43k8*7@JHkjhkLABLA';
$enc = $utils->encode_string($str); 
ok(length($enc) == 512, "Encoded string for input 332 chars is 512 chars long.");

$enc64 = $utils->encode_string_base64($str);
ok(length($enc64) == 692, "Encoded string for input 332 chars is 692 chars long.");
$dec = $utils->decode_string($enc);
ok($dec eq $str, "Decoded string is equal to original string.");

$str = 'boris@gmail.com';
my $email_x = $utils->scramble_email($str); 
ok(length($email_x) == 33, "Scrambled email is 33 chars long.");
ok($email_x =~ m![^@]+\@[^@]+!, "Scrambled email has 2 parts separated by \@.");
my ($name_x, $comp_x) = split(/\@/, $email_x);

$str = 'toto@gmail.com';
my $email_y = $utils->scramble_email($str);
ok(length($email_y) == 33, "Scrambled email is 33 chars long.");
ok($email_y =~ m![^@]+\@[^@]+!, "Scrambled email has 2 parts separated by \@.");
my ($name_y, $comp_y) = split(/\@/, $email_y);
ok($comp_x eq $comp_y, "Companies for both emails are similar.");

$str = 'trinity-823a6d2b-0639-447b-8970-ea13dea1ed40-1464795259694@3capp-gmx-bs60';
$email_x = $utils->scramble_email($str); 
ok(length($email_x) == 33, "Scrambled email is 33 chars long.");
ok($email_x =~ m![^@]+\@[^@]+!, "Scrambled email has 2 parts separated by \@.");

$str = '';
$email_x = $utils->scramble_email($str); 
ok(length($email_x) == 33, "Scrambled empty email is 33 chars long.");
ok($email_x =~ m![^@]+\@[^@]+!, "Scrambled empty email has 2 parts separated by \@.");


$str = 'This is a long text with some email address hidden like boris@gmail.com and some text after.';
$email_x = $utils->auto_scramble($str); 
ok(length($email_x) == 110, "Scrambled email is 110 chars long.");
ok($email_x =~ m!^This is a long text with some email address hidden like !, "Scrambled email has correct beginning.");
ok($email_x =~ m! and some text after.$!, "Scrambled email has correct ending.");

done_testing();
