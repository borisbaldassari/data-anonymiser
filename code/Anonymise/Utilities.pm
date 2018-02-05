package Anonymise::Utilities;

use strict;
use warnings;

use Crypt::PK::RSA;
use MIME::Base64;

use Data::Dumper;

my $pk = Crypt::PK::RSA->new();

sub new {
    my $class = shift;
    my $self = {
    };
#      _key_priv => shift,
#      _key_pub  => shift,
#      _ssn       => shift,
    # Print all the values just for clarification.
    $pk = Crypt::PK::RSA->new();
    
    bless $self, $class;
    return $self;
}


sub create_keys() {
    my $self = shift;
    my $key_size = shift || 512;

    # Key generation
#    $pk->generate_key($key_size);

    #Key generation
    $pk->generate_key(256, 65537);
    my $private_der = encode_base64( $pk->export_key_der('private') );
    my $public_der = encode_base64( $pk->export_key_der('public') );
#    print "PRIV " . Dumper($private_der);
#    print "PUB " . Dumper($public_der);

    return $public_der;
}

sub scramble_string() {
    my $self = shift;
    my $in = shift || '';

    my $out = $pk->encrypt($in);
    
    # It is ok to truncate hashes, and encoding base64 makes
    # the collision risk a bit lower. For a good explanation see
    # https://stackoverflow.com/questions/4567089/hash-function-that-produces-short-hashes
    my $out_short = substr( encode_base64($out), 0, 16 );

    return $out_short;
}

sub encode_string($) {
    my $self = shift;
    my $in = shift || '';

    my $out = $pk->encrypt($in);

    return $out;
}

sub encode_string_base64($) {
    my $self = shift;
    my $in = shift || '';

    my $out = encode_base64( $self->encode_string($in) );
    chomp($out);

    return $out;
}


sub decode_string($) {
    my $self = shift;
    my $in = shift || '';

    my $out = $pk->decrypt( $in );

    return $out;
}

1;
