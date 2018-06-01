######################################################################
# Copyright (c) 2017-2018 Castalia Solutions and others
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
######################################################################


package Anonymise::Utilities;

use strict;
use warnings;

use Crypt::PK::RSA;
use MIME::Base64;

use Data::Dumper;

# The Crypt::PK::RSA object that will be used during this session.
my $pk;

my %known_scramble;
my %known_encode;

sub new {
    my $class = shift;
    my $self = {
    };

    $pk = Crypt::PK::RSA->new();
    
    bless $self, $class;
    return $self;
}

# Imports the pair of public/private key.
# Params: 
#   - The private key.
sub import_private_key_der() {
    my $self = shift;
    my $key = shift or die 'Need a key when importing!';
  
    $pk->import_key(\$key);

    return 1;
}

# Exports the pair of public/private key.
# Returns: 
#   - The private key (binary data).
sub export_private_key_der() {
    my $self = shift;

    my $private_der = $pk->export_key_der('private');

    return $private_der;
}

# Imports the pair of public/private key.
# Params: 
#   - The public key.
sub import_public_key_der() {
    my $self = shift;
    my $key = shift or die 'Need a key when importing!';
  
    $pk->import_key(\$key);

    return 1;
}

# Exports the pair of public/private key.
# Returns: 
#   - The public key (binary data).
sub export_public_key_der() {
    my $self = shift;

    my $public_der = $pk->export_key_der('public');

    return $public_der;
}

# Creates a pair of public/private key with size 512.
# Returns: 
#   - The public key encoded in base64.
sub create_keys() {
    my $self = shift;

    # Key generation
    $pk->generate_key(512, 65537);
    my $public_der = encode_base64( $pk->export_key_der('public') );

    return $public_der;
}


# Encode a string with the generated public/private key and returns 
# a string truncated to 16 chars. Output is base64-encoded.
# Note that this function is one-way: it is not possible to retrieve
# the plain text string from the truncated output.
#
# Params:
#   - $in the plain text string to encode
# Returns:
#   - the encoded string encoded in base64
sub scramble_string() {
    my $self = shift;
    my $in = shift || '';

    # Reuse item if it has already been scrambled.
    if ( exists($known_scramble{$in}) ) {
	return $known_scramble{$in};
    } else {
    }
    
    # If the in string is longer than 470, it fails. It's a lot more than 
    # our nominal use case, so just truncate it at 470.
    my $in_s = substr( $in, 0, 470 ); 
    
    my $out = $pk->encrypt($in_s);
    
    # It is ok to truncate hashes, and encoding base64 makes
    # the collision risk a bit lower. For a good explanation see
    # https://stackoverflow.com/questions/4567089/hash-function-that-produces-short-hashes
    my $out_short = substr( encode_base64($out), 0, 16 );

    $known_scramble{$in} = $out_short;
    
    return $out_short;
}


# Encode an email address with the generated public/private key and returns 
# a string truncated to 16 chars. Output is base64-encoded.
# Note that this function is one-way: it is not possible to retrieve
# the plain text string from the truncated output.
#
# Params:
#   - $in the plain text string to encode
# Returns:
#   - the encoded string encoded in base64
sub scramble_email() {
    my $self = shift;
    my $in = shift || '';

    my ($name, $comp) = split('@', $in);
    my $name_x = &scramble_string($self, $name);
    my $comp_x = &scramble_string($self, $comp);

    my $out_short = $name_x . '@' . $comp_x;
    
    return $out_short;
}

# Encode a string with the generated public/private key and returns 
# the string. The output will include weird chars.
#
# Params:
#   - $in the plain text string to encode
# Returns:
#   - the encoded string
sub encode_string($) {
    my $self = shift;
    my $in = shift || '';

    # Reuse item if it has already been scrambled.
    if ( exists($known_encode{$in}) ) {
	return $known_encode{$in};
    }
    
    my $out = $pk->encrypt($in);

    $known_encode{$in} = $out;
    
    return $out;
}

# Encode a string with the generated public/private key and returns 
# a base64-encoded string.
#
# Params:
#   - $in the plain text string to encode
# Returns:
#   - the encoded string in base64
sub encode_string_base64($) {
    my $self = shift;
    my $in = shift || '';

    my $out = encode_base64( $self->encode_string($in) );
    chomp($out);

    return $out;
}

# Decode a string based on the generated public/private key.
#
# Params:
#   - $in the encoded string to decode
# Returns:
#   - the decoded string
sub decode_string() {
    my $self = shift;
    my $in = shift || '';

    my $out = $pk->decrypt( $in );

    return $out;
}


#
sub auto_scramble() {
    my $self = shift;
    my $in = shift || '';

    # Detect email addresses
    $in =~ s!([^@\s]+\@[^.]+\.\S+)!&scramble_email($self, $1)!ge;
    
    return $in;
}


1;
