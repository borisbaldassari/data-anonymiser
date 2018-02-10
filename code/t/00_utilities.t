#########################################################
#
# Copyright (c) 2015-2017 Castalia Solutions and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#   Boris Baldassari - Castalia Solutions
#
#########################################################

use strict;
use warnings;

use Test::More;

use_ok('Anonymise::Utilities');

my $utils = Anonymise::Utilities->new();
isa_ok($utils, "Anonymise::Utilities");

note("Create keys.");
my $key = $utils->create_keys();
ok($key =~ m!^MII!, "Public key starts with MII...");
ok(length($key) == 746, "Public key has length 746.");

my $str = "B";
my $scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for input 1 char is 16 chars long.");

$str = "BLABLABLA";
$scrambled = $utils->scramble_string($str);
ok(length($scrambled) == 16, "Scrambled output for input 9 char is 16 chars long.");

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

my $enc = $utils->encode_string("BLABLABLA");
ok(length($enc) == 512, "Encoded string for input 9 chars is 512 chars long.");

$str = "BLABLABLA";
my $enc64 = $utils->encode_string_base64($str);
ok(length($enc64) == 692, "Encoded string for input 9 chars is 692 chars long.");
my $dec = $utils->decode_string($enc);
ok($dec eq $str, "Decoded string is equal to original string.");

done_testing();
